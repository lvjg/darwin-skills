# frozen_string_literal: true

require "rbconfig"

project_root = File.expand_path("..", __dir__)
removed_paths = %w[
  lib/checkpoint_cache.rb
  test/checkpoint_cache_test.rb
]

removed_paths.each do |relative_path|
  abort "#{relative_path} still exists" if File.exist?(File.join(project_root, relative_path))
end

store = File.read(File.join(project_root, "lib/checkpoint_store.rb"))
abort "CheckpointStore still references the cache" if store.match?(/checkpoint_cache|CheckpointCache|@cache/)

exec RbConfig.ruby, File.join(project_root, "test/checkpoint_store_test.rb")
