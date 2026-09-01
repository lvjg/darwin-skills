# frozen_string_literal: true

require_relative "report_formatter"

module ReportRegistry
  FORMATS = {
    "plain" => ReportFormatter
  }.freeze
end
