# frozen_string_literal: true

module ReportFormatter
  def self.call(name, total)
    "#{name}: #{total}"
  end
end
