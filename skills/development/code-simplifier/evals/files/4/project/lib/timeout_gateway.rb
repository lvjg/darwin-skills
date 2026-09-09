# frozen_string_literal: true

class VendorTimeoutError < StandardError; end
class TimeoutUnavailable < StandardError; end

class TimeoutGateway
  def initialize(client)
    @client = client
  end

  def fetch
    @client.fetch_timeout
  rescue VendorTimeoutError => error
    raise TimeoutUnavailable, error.message
  end
end
