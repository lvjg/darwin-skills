# frozen_string_literal: true

require_relative "parcel_cloud"

class RateUnavailable < StandardError; end

class DeliveryPlanner
  def initialize(client)
    @client = client
  end

  def quote(postal_code)
    { cents: @client.fetch_rate(postal_code) }
  rescue ParcelCloud::Unavailable => error
    raise RateUnavailable, error.message
  end
end
