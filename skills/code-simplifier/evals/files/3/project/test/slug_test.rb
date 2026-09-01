# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/slug"

class SlugTest < Minitest::Test
  def test_normalizes_the_import_label
    assert_equal "weekly-report", Slug.call("  Weekly   Report  ")
  end
end
