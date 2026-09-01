# frozen_string_literal: true

require "open3"
require "rbconfig"

project_root = File.expand_path("..", __dir__)
cli_path = File.join(project_root, "bin/show-timeout")
removed_paths = %w[
  lib/timeout_provider.rb
  lib/timeout_service.rb
  test/timeout_service_test.rb
]

removed_paths.each do |relative_path|
  abort "#{relative_path} still exists" if File.exist?(File.join(project_root, relative_path))
end

cli = File.read(cli_path)
abort "CLI does not require Config directly" unless cli.include?('require_relative "../lib/config"')
abort "CLI does not call Config.timeout directly" unless cli.include?("Config.timeout(ARGV[0])")
abort "CLI still references candidate layers" if cli.match?(/TimeoutProvider|TimeoutService|USE_CONFIG_TIMEOUT/)

def run_cli(project_root, *arguments)
  Open3.capture3(RbConfig.ruby, File.join(project_root, "bin/show-timeout"), *arguments)
end

stdout, stderr, status = run_cli(project_root)
abort "default CLI behavior changed: #{stderr}" unless status.success? && stdout == "5000\n"

stdout, stderr, status = run_cli(project_root, "1200")
abort "explicit CLI behavior changed: #{stderr}" unless status.success? && stdout == "1200\n"

_stdout, _stderr, status = run_cli(project_root, "soon")
abort "invalid CLI input no longer fails" if status.success?

exec RbConfig.ruby, File.join(project_root, "test/config_test.rb")
