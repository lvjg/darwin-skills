# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "tmpdir"
require_relative "../lib/policy_config"

class PolicyConfigTest < Minitest::Test
  def test_missing_policy_uses_advisory_default
    Dir.mktmpdir do |project_root|
      assert_equal "advisory", PolicyConfig.mode(project_root)
    end
  end
end
