# frozen_string_literal: true

module JobTimeout
  def self.parse(raw)
    return 5_000 if raw.nil?

    Integer(raw, 10)
  rescue ArgumentError
    5_000
  end
end
