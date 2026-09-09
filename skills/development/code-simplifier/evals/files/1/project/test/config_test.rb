# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/config"

class ConfigTest < Minitest::Test
  def test_default_timeout
    assert_equal 5_000, Config.timeout(nil)
  end

  def test_explicit_timeout
    assert_equal 1200, Config.timeout("1200")
  end

  def test_invalid_timeout
    assert_raises(ArgumentError) { Config.timeout("soon") }
  end
end
