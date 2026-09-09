# frozen_string_literal: true

require_relative "timeout_service"

module TimeoutProvider
  def self.build
    TimeoutService.new
  end
end
