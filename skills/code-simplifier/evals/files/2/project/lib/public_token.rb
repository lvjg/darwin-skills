# frozen_string_literal: true

module PublicToken
  def self.parse(value)
    TokenParser.parse(value)
  end
end
