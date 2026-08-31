#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent.realpath
errors = []

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

  skill_name
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
  errors << "README.md: migration guide is not linked" unless readme_text.include?("MIGRATIONS.md")
end

markdown_files = [ROOT.join("README.md"), ROOT.join("MIGRATIONS.md")] + ROOT.glob("skills/**/*.md") + ROOT.glob("codex/**/*.md")
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
  base_index = ARGV.index("--base")
  base = base_index ? ARGV[base_index + 1] : ENV["PACKAGING_BASE_REF"]
  base = "HEAD" if base.nil? || base.empty?
  _out, _err, valid_base = Open3.capture3("git", "-C", ROOT.to_s, "rev-parse", "--verify", "#{base}^{commit}")

  if valid_base.success?
    diff, diff_error, diff_status = Open3.capture3("git", "-C", ROOT.to_s, "diff", "--name-status", "--find-renames", base, "--", "skills")
    if diff_status.success?
      retired_names = diff.lines.map do |line|
        fields = line.chomp.split("\t")
        old_path = fields[0].start_with?("D") ? fields[1] : (fields[0].start_with?("R") ? fields[1] : nil)
        old_path&.match(%r{\Askills/([^/]+)/SKILL\.md\z})&.captures&.first
      end.compact.uniq
      migration_text = migrations.read
      retired_names.each do |retired_name|
        errors << "MIGRATIONS.md: retired Skill #{retired_name.inspect} is not mapped" unless migration_text.include?("`#{retired_name}`")
      end
    else
      errors << "git diff against #{base.inspect} failed: #{diff_error.strip}"
    end

    check_out, check_error, check_status = Open3.capture3(
      "git", "-C", ROOT.to_s, "diff", "--check", base, "--",
      "README.md", "MIGRATIONS.md", "skills", "codex", "scripts", ".github"
    )
    unless check_status.success?
      details = [check_out, check_error].map(&:strip).reject(&:empty?).join("\n")
      errors << "git diff --check failed:\n#{details}"
    end
  else
    errors << "cannot verify packaging comparison base #{base.inspect}"
  end
end

if errors.empty?
  puts "Packaging check passed for #{skill_names.length} Skills."
  exit 0
end

warn "Packaging check failed:"
errors.each { |error| warn "- #{error}" }
exit 1
