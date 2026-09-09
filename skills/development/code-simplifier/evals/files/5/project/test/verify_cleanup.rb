# frozen_string_literal: true

require "rbconfig"

project_root = File.expand_path("..", __dir__)
removed_paths = %w[
  lib/report_registry.rb
  config/reporting.yml
  test/report_registry_test.rb
]

removed_paths.each do |relative_path|
  abort "#{relative_path} still exists" if File.exist?(File.join(project_root, relative_path))
end

exec RbConfig.ruby, File.join(project_root, "test/report_formatter_test.rb")
