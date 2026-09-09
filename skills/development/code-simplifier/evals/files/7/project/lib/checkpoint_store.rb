# frozen_string_literal: true

require_relative "checkpoint_cache"

class CheckpointStore
  def initialize(path)
    @path = path
    @cache = CheckpointCache.new
  end

  def write(offset)
    normalized = Integer(offset)
    File.write(@path, normalized.to_s)
    @cache.write(normalized)
  end

  def read
    cached = @cache.read
    return cached unless cached.nil?

    Integer(File.read(@path), 10)
  rescue Errno::ENOENT, ArgumentError
    0
  end

  def clear
    File.delete(@path) if File.exist?(@path)
    @cache.clear
  end
end
