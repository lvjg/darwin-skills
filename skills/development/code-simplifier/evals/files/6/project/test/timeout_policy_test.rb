# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/web_timeout"
require_relative "../lib/job_timeout"

class TimeoutPolicyTest < Minitest::Test
  def test_both_paths_accept_integer_text
    assert_equal 1200, WebTimeout.parse("1200")
    assert_equal 1200, JobTimeout.parse("1200")
  end

  def test_web_rejects_invalid_input
    assert_raises(ArgumentError) { WebTimeout.parse("soon") }
  end

  def test_job_defaults_invalid_or_missing_input
    assert_equal 5_000, JobTimeout.parse("soon")
    assert_equal 5_000, JobTimeout.parse(nil)
  end
end
