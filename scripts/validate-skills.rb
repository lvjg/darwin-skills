#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "json"
require "optparse"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent.realpath
errors = []
comparison_base = "HEAD"
parser = OptionParser.new do |options|
  options.banner = "Usage: ruby scripts/validate-skills.rb [--base REF]"
  options.on("--base REF", "Git comparison base (default: HEAD)") { |value| comparison_base = value }
end
begin
  parser.parse!
rescue OptionParser::ParseError => e
  abort "#{e.message}\n#{parser}"
end

def check!(condition, message)
  raise ArgumentError, message unless condition
end

def read_mapping(path, frontmatter: false)
  text = path.read
  if frontmatter
    text = text[/\A---\s*\n(.*?)\n---\s*\n/m, 1]
    check!(text, "missing YAML frontmatter")
  end
  value = path.extname == ".json" ? JSON.parse(text) : YAML.safe_load(text, aliases: false)
  check!(value.is_a?(Hash), "must contain an object")
  value
rescue Errno::ENOENT, Psych::Exception, JSON::ParserError, ArgumentError => e
  raise ArgumentError, "#{path.relative_path_from(ROOT)}: #{e.message.lines.first.strip}"
end

def nonempty_text?(value)
  value.is_a?(String) && !value.strip.empty?
end

def git(*args)
  out, err, status = Open3.capture3("git", "-C", ROOT.to_s, *args)
  check!(status.success?, "git #{args.join(' ')} failed: #{[out, err].reject(&:empty?).join("\n").strip}")
  out
end

skill_files = ROOT.glob("skills/*/SKILL.md").sort
skill_names = skill_files.map { |file| file.parent.basename.to_s }
errors << "skills/: no discoverable Skills" if skill_files.empty?
skill_files.each do |file|
  name = file.parent.basename.to_s
  begin
    metadata = read_mapping(file, frontmatter: true)
    check!(metadata["name"] == name, "name must equal directory #{name.inspect}")
    check!(name.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/) && name.length <= 64, "invalid Skill name")
    description = metadata["description"]
    check!(description.is_a?(String) && description.length.between?(1, 1024), "description must contain 1..1024 characters")

    agent = read_mapping(file.parent.join("agents/openai.yaml"))
    interface = agent["interface"]
    check!(interface.is_a?(Hash), "agents/openai.yaml: interface must be an object")
    %w[display_name short_description default_prompt].each do |key|
      check!(nonempty_text?(interface[key]), "agents/openai.yaml: interface.#{key} must be non-empty text")
    end
    check!(interface["default_prompt"].include?("$#{name}"), "default_prompt must explicitly invoke $#{name}")
    check!(agent["policy"].is_a?(Hash) && agent["policy"]["allow_implicit_invocation"] == false, "implicit invocation must remain disabled")

    eval_set = read_mapping(file.parent.join("evals/evals.json"))
    check!((eval_set.keys - %w[skill_name evals]).empty?, "evals.json: unsupported fields")
    check!(eval_set["skill_name"] == name, "evals.json: skill_name must equal #{name.inspect}")
    cases = eval_set["evals"]
    check!(cases.is_a?(Array) && !cases.empty?, "evals.json: evals must be a non-empty array")
    ids = []
    cases.each_with_index do |item, index|
      location = "evals.json#/evals/#{index}"
      check!(item.is_a?(Hash), "#{location}: must be an object")
      check!((item.keys - %w[id prompt expected_output files expectations]).empty?, "#{location}: unsupported fields")
      id = item["id"]
      check!(id.is_a?(Integer) && !ids.include?(id), "#{location}: id must be a unique integer")
      ids << id
      %w[prompt expected_output].each do |key|
        check!(nonempty_text?(item[key]), "#{location}: #{key} must be non-empty text")
      end
      expectations = item["expectations"]
      check!(expectations.is_a?(Array) && !expectations.empty? && expectations.all? { |value| nonempty_text?(value) }, "#{location}: expectations must be a non-empty text array")
      files = item.fetch("files", [])
      check!(files.is_a?(Array) && files.all? { |value| value.is_a?(String) && !value.empty? }, "#{location}: files must be a string array")
      files.each do |path|
        relative = Pathname.new(path)
        check!(!relative.absolute? && !relative.each_filename.include?("..") && path.start_with?("evals/files/#{id}/"), "#{location}: fixture must stay under evals/files/#{id}/: #{path.inspect}")
        check!(file.parent.join(relative).file?, "#{location}: missing fixture #{path.inspect}")
      end
    end
  rescue ArgumentError => e
    errors << "skills/#{name}: #{e.message}"
  end
end

if skill_names.include?("supervisor")
  fallback = ROOT.join("skills/supervisor/references/capability-fallback.md")
  begin
    names = fallback.read.scan(/^- `([a-z0-9]+(?:-[a-z0-9]+)*)`\s*$/).flatten
    expected = skill_names - ["supervisor"]
    check!(names.sort == expected.sort, "#{fallback.relative_path_from(ROOT)}: must list each repository specialist exactly once (expected #{expected.sort.inspect}, got #{names.sort.inspect})")
  rescue Errno::ENOENT, ArgumentError => e
    errors << e.message
  end
end

begin
  readme = ROOT.join("README.md").read
  skill_names.each do |name|
    errors << "README.md: missing Skill inventory link for #{name}" unless readme.include?("skills/#{name}/SKILL.md")
  end
rescue Errno::ENOENT => e
  errors << e.message
end

markdown_files = [ROOT.join("README.md"), ROOT.join("MIGRATIONS.md")] + ROOT.glob("{skills,codex,evals}/**/*.md")
markdown_files.select(&:file?).uniq.each do |file|
  file.read.scan(/\]\(([^)]+)\)/).flatten.each do |raw|
    target = raw.strip.sub(/\A<(.+)>\z/, "\\1").split(/\s+[\"']/).first
    next if target.nil? || target.empty? || target.start_with?("#") || target.match?(/\A[a-z][a-z0-9+.-]*:/i)

    resolved = file.parent.join(target.split("#", 2).first).cleanpath
    errors << "#{file.relative_path_from(ROOT)}: broken local link #{target}" unless resolved.exist?
  end
end

begin
  mappings = ROOT.join("MIGRATIONS.md").read.lines.flat_map do |line|
    cells = line.split("|")
    cells.length >= 3 ? cells[1].scan(/`([^`]+)`/).flatten : []
  end
  base = "#{comparison_base}^{commit}"
  diff = git("diff", "--name-status", "--find-renames", base, "--", "skills")
  diff.lines.each do |line|
    status, old_path = line.chomp.split("\t")
    next unless status.start_with?("D", "R")

    name = old_path.match(%r{\Askills/([^/]+)/SKILL\.md\z})&.captures&.first
    errors << "MIGRATIONS.md: retired Skill #{name.inspect} is not mapped from a source column" if name && !mappings.include?(name)
  end
  git("diff", "--check", base, "--", "README.md", "MIGRATIONS.md", "skills", "codex", "evals", "scripts", ".github")
rescue Errno::ENOENT, ArgumentError => e
  errors << e.message
end

abort "Skill package validation failed:\n#{errors.map { |error| "- #{error}" }.join("\n")}" unless errors.empty?
puts "Validated #{skill_names.length} Skill package(s), each with one Anthropic eval set."
