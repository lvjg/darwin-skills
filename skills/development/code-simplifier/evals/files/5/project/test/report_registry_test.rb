# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/report_registry"

class ReportRegistryTest < Minitest::Test
  def test_registers_plain_formatter
    assert_equal ReportFormatter, ReportRegistry::FORMATS.fetch("plain")
  end
end
