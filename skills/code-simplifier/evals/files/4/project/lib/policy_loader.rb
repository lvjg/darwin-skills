# frozen_string_literal: true

require_relative "timeout_gateway"

class PolicyLoader
  def initialize(timeout_gateway)
    @timeout_gateway = timeout_gateway
  end

  def load
    { timeout: @timeout_gateway.fetch }
  end
end
