# frozen_string_literal: true

module Slug
  def self.call(value)
    value.strip.downcase.gsub(/\s+/, "-")
  end
end
