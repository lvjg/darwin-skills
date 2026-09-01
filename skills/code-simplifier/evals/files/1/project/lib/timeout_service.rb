# frozen_string_literal: true

require_relative "config"

class TimeoutService
  def timeout(raw)
    return Config.timeout(raw) if ENV.fetch("USE_CONFIG_TIMEOUT", "true") == "true"

    raw.nil? ? 5_000 : Integer(raw, 10)
  rescue ArgumentError
    Config.timeout(raw)
  end
end
