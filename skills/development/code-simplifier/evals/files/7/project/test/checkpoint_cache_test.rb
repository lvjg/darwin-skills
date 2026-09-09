# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/checkpoint_cache"

class CheckpointCacheTest < Minitest::Test
  def test_stores_the_latest_offset
    cache = CheckpointCache.new
    cache.write(12)

    assert_equal 12, cache.read
  end
end
