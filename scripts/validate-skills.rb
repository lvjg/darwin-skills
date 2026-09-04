#!/usr/bin/env ruby
# frozen_string_literal: true

# Validate repository-owned static contracts for every published Skill package.

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

def read_yaml(path, errors)
  YAML.safe_load(path.read, permitted_classes: [], permitted_symbols: [], aliases: false) || {}
rescue Psych::Exception => e
  errors << "#{path.relative_path_from(ROOT)}: invalid YAML (#{e.message.lines.first.strip})"
  {}
end

def frontmatter(path, errors)
  content = path.read
  match = content.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  unless match
    errors << "#{path.relative_path_from(ROOT)}: missing YAML frontmatter"
    return {}
  end

  YAML.safe_load(match[1], permitted_classes: [], permitted_symbols: [], aliases: false) || {}
rescue Psych::Exception => e
  errors << "#{path.relative_path_from(ROOT)}: invalid frontmatter (#{e.message.lines.first.strip})"
  {}
end

def migration_source_names(path)
  path.read.lines.flat_map do |line|
    cells = line.split("|")
    next [] if cells.length < 3

    cells[1].scan(/`([^`]+)`/).flatten
  end.uniq
end

skill_files = ROOT.glob("skills/*/SKILL.md").sort
errors << "skills/: no discoverable Skills" if skill_files.empty?

skill_names = skill_files.map do |skill_file|
  skill_name = skill_file.parent.basename.to_s
  metadata = frontmatter(skill_file, errors)
  declared_name = metadata["name"]
  description = metadata["description"]

  errors << "#{skill_file.relative_path_from(ROOT)}: name must equal directory #{skill_name.inspect}" unless declared_name == skill_name
  errors << "#{skill_file.relative_path_from(ROOT)}: invalid Skill name" unless skill_name.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/) && skill_name.length <= 64
  errors << "#{skill_file.relative_path_from(ROOT)}: description must contain 1..1024 characters" unless description.is_a?(String) && description.length.between?(1, 1024)

  agent_file = skill_file.parent.join("agents/openai.yaml")
  if !agent_file.file?
    errors << "#{agent_file.relative_path_from(ROOT)}: missing"
  else
    agent = read_yaml(agent_file, errors)
    interface = agent["interface"] || {}
    %w[display_name short_description default_prompt].each do |key|
      value = interface[key]
      errors << "#{agent_file.relative_path_from(ROOT)}: interface.#{key} must be a non-empty string" unless value.is_a?(String) && !value.strip.empty?
    end
    prompt = interface["default_prompt"]
    errors << "#{agent_file.relative_path_from(ROOT)}: default_prompt must explicitly invoke $#{skill_name}" unless prompt.is_a?(String) && prompt.include?("$#{skill_name}")
    errors << "#{agent_file.relative_path_from(ROOT)}: implicit invocation must remain disabled" unless agent.dig("policy", "allow_implicit_invocation") == false
  end

  eval_file = skill_file.parent.join("evals/evals.json")
  unless eval_file.file?
    errors << "#{eval_file.relative_path_from(ROOT)}: missing"
    next skill_name
  end

  begin
    eval_set = JSON.parse(eval_file.read)
    unless eval_set.is_a?(Hash)
      errors << "#{eval_file.relative_path_from(ROOT)}: top level must be an object"
      next skill_name
    end
    top_level_keys = eval_set.keys - %w[skill_name evals]
    errors << "#{eval_file.relative_path_from(ROOT)}: unsupported fields #{top_level_keys.inspect}" unless top_level_keys.empty?
    errors << "#{eval_file.relative_path_from(ROOT)}: skill_name must equal #{skill_name.inspect}" unless eval_set["skill_name"] == skill_name
    evals = eval_set["evals"]
    if !evals.is_a?(Array) || evals.empty?
      errors << "#{eval_file.relative_path_from(ROOT)}: evals must be a non-empty array"
    else
      ids = []
      evals.each_with_index do |item, index|
        location = "#{eval_file.relative_path_from(ROOT)}#/evals/#{index}"
        unless item.is_a?(Hash)
          errors << "#{location}: must be an object"
          next
        end

        unsupported_fields = item.keys - %w[id prompt expected_output files expectations]
        errors << "#{location}: unsupported fields #{unsupported_fields.inspect}" unless unsupported_fields.empty?

        id = item["id"]
        errors << "#{location}/id: must be an integer" unless id.is_a?(Integer)
        ids << id if id.is_a?(Integer)
        %w[prompt expected_output].each do |field|
          value = item[field]
          errors << "#{location}/#{field}: must be a non-empty string" unless value.is_a?(String) && !value.strip.empty?
        end

        expectations = item["expectations"]
        unless expectations.is_a?(Array) && !expectations.empty? && expectations.all? { |value| value.is_a?(String) && !value.strip.empty? }
          errors << "#{location}/expectations: must be a non-empty string array"
        end

        files = item.fetch("files", [])
        if !files.is_a?(Array) || !files.all? { |value| value.is_a?(String) && !value.empty? }
          errors << "#{location}/files: must be a string array"
          next
        end
        files.each do |raw_path|
          relative = Pathname.new(raw_path)
          if relative.absolute? || relative.each_filename.include?("..")
            errors << "#{location}/files: path must stay inside the Skill: #{raw_path.inspect}"
            next
          end
          expected_prefix = "evals/files/#{id}/"
          unless id.is_a?(Integer) && raw_path.start_with?(expected_prefix)
            errors << "#{location}/files: fixture must be isolated under #{expected_prefix.inspect}: #{raw_path.inspect}"
          end
          target = skill_file.parent.join(relative).cleanpath
          errors << "#{location}/files: missing #{raw_path.inspect}" unless target.file?
        end
      end
      duplicate_ids = ids.group_by(&:itself).select { |_id, items| items.length > 1 }.keys
      errors << "#{eval_file.relative_path_from(ROOT)}: duplicate eval ids #{duplicate_ids.inspect}" unless duplicate_ids.empty?
    end
  rescue JSON::ParserError => e
    errors << "#{eval_file.relative_path_from(ROOT)}: invalid JSON (#{e.message})"
  end

  skill_name
end

supervisor_file = ROOT.join("skills/supervisor/SKILL.md")
if supervisor_file.file?
  supervisor_text = supervisor_file.read
  discovery_section = supervisor_text[/^## 发现专业能力\n(.*?)(?=^## |\z)/m, 1]
  errors << "skills/supervisor/SKILL.md: missing professional capability discovery section" if discovery_section.nil?

  fallback_file = supervisor_file.parent.join("references/capability-fallback.md")
  if !fallback_file.file?
    errors << "skills/supervisor/references/capability-fallback.md: missing"
  else
    fallback_names = fallback_file.read.scan(/^- `([a-z0-9]+(?:-[a-z0-9]+)*)`\s*$/).flatten
    expected_fallback_names = skill_names.reject { |name| name == "supervisor" }
    duplicate_fallback_names = fallback_names.group_by(&:itself).select { |_name, items| items.length > 1 }.keys
    unless duplicate_fallback_names.empty?
      errors << "#{fallback_file.relative_path_from(ROOT)}: duplicate professional Skills #{duplicate_fallback_names.inspect}"
    end
    unless fallback_names.sort == expected_fallback_names.sort
      errors << "#{fallback_file.relative_path_from(ROOT)}: fallback Skills must exactly match repository specialists (expected #{expected_fallback_names.sort.inspect}, got #{fallback_names.sort.inspect})"
    end
  end
end

readme = ROOT.join("README.md")
if !readme.file?
  errors << "README.md: missing"
else
  readme_text = readme.read
  skill_names.each do |skill_name|
    expected_link = "skills/#{skill_name}/SKILL.md"
    errors << "README.md: missing Skill inventory link #{expected_link}" unless readme_text.include?(expected_link)
  end
end

markdown_files = [ROOT.join("README.md"), ROOT.join("MIGRATIONS.md")] + ROOT.glob("skills/**/*.md") + ROOT.glob("codex/**/*.md") + ROOT.glob("evals/**/*.md")
markdown_files.select(&:file?).uniq.each do |markdown_file|
  markdown_file.read.scan(/\]\(([^)]+)\)/).flatten.each do |raw_target|
    target = raw_target.strip.sub(/\A<(.+)>\z/, "\\1").split(/\s+[\"']/).first
    next if target.nil? || target.empty? || target.start_with?("#") || target.match?(/\A[a-z][a-z0-9+.-]*:/i)

    local_path = target.split("#", 2).first
    resolved = markdown_file.parent.join(local_path).cleanpath
    errors << "#{markdown_file.relative_path_from(ROOT)}: broken local link #{target}" unless resolved.exist?
  end
end

migrations = ROOT.join("MIGRATIONS.md")
if !migrations.file?
  errors << "MIGRATIONS.md: missing"
else
  base = comparison_base
  _out, _err, valid_base = Open3.capture3("git", "-C", ROOT.to_s, "rev-parse", "--verify", "#{base}^{commit}")

  if valid_base.success?
    diff, diff_error, diff_status = Open3.capture3("git", "-C", ROOT.to_s, "diff", "--name-status", "--find-renames", base, "--", "skills")
    if diff_status.success?
      retired_names = diff.lines.map do |line|
        fields = line.chomp.split("\t")
        old_path = fields[0].start_with?("D") ? fields[1] : (fields[0].start_with?("R") ? fields[1] : nil)
        old_path&.match(%r{\Askills/([^/]+)/SKILL\.md\z})&.captures&.first
      end.compact.uniq
      mapped_retired_names = migration_source_names(migrations)
      retired_names.each do |retired_name|
        errors << "MIGRATIONS.md: retired Skill #{retired_name.inspect} is not mapped from a migration table source column" unless mapped_retired_names.include?(retired_name)
      end
    else
      errors << "git diff against #{base.inspect} failed: #{diff_error.strip}"
    end

    check_out, check_error, check_status = Open3.capture3(
      "git", "-C", ROOT.to_s, "diff", "--check", base, "--",
      "README.md", "MIGRATIONS.md", "skills", "codex", "evals", "scripts", ".github"
    )
    unless check_status.success?
      details = [check_out, check_error].map(&:strip).reject(&:empty?).join("\n")
      errors << "git diff --check failed:\n#{details}"
    end
  else
    errors << "cannot verify Skill comparison base #{base.inspect}"
  end
end

if errors.empty?
  puts "Validated #{skill_names.length} Skill package(s), each with one Anthropic eval set."
  exit 0
end

warn "Skill package validation failed:"
errors.each { |error| warn "- #{error}" }
exit 1
