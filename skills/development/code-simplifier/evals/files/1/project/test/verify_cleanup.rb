# frozen_string_literal: true

require "open3"
require "rbconfig"

project_root = File.expand_path("..", __dir__)
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
