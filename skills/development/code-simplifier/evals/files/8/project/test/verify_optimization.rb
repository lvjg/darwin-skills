# frozen_string_literal: true

project_root = File.expand_path("..", __dir__)
gateway_path = File.join(project_root, "lib/shipping_rate_gateway.rb")
planner_path = File.join(project_root, "lib/delivery_planner.rb")

abort "shipping rate gateway is missing" unless File.exist?(gateway_path)

gateway = File.read(gateway_path)
planner = File.read(planner_path)

abort "gateway does not own the vendor call" unless gateway.include?("fetch_rate")
abort "gateway does not translate the vendor error" unless gateway.include?("ParcelCloud::Unavailable") && gateway.include?("RateUnavailable")
abort "DeliveryPlanner still leaks the vendor protocol" if planner.match?(/ParcelCloud|fetch_rate/)
abort "DeliveryPlanner does not call the gateway contract" unless planner.include?(".fetch(postal_code)")

require gateway_path
require planner_path

client_class = Struct.new(:rate, :error) do
  def fetch_rate(_postal_code)
    raise error if error

    rate
  end
end

planner = DeliveryPlanner.new(ShippingRateGateway.new(client_class.new(1250)))
abort "quote behavior changed" unless planner.quote("10001") == { cents: 1250 }

failing_client = client_class.new(nil, ParcelCloud::Unavailable.new("offline"))
planner = DeliveryPlanner.new(ShippingRateGateway.new(failing_client))

begin
  planner.quote("10001")
  abort "vendor failure was swallowed"
rescue RateUnavailable => error
  abort "failure message changed" unless error.message == "offline"
end
