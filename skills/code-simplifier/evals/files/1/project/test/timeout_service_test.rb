# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/timeout_service"

class TimeoutServiceTest < Minitest::Test
  def test_delegates_to_config
    assert_equal 5_000, TimeoutService.new.timeout(nil)
  end
end
