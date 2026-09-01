# frozen_string_literal: true

module Config
  def self.timeout(raw)
    return 5_000 if raw.nil?

    Integer(raw, 10)
  end
end
