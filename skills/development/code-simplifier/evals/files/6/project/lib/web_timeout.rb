# frozen_string_literal: true

module WebTimeout
  def self.parse(raw)
    Integer(raw, 10)
  end
end
