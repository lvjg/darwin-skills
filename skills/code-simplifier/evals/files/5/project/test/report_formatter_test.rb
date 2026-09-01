# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/report_formatter"

class ReportFormatterTest < Minitest::Test
  def test_formats_name_and_total
    assert_equal "sales: 3", ReportFormatter.call("sales", 3)
  end
end
