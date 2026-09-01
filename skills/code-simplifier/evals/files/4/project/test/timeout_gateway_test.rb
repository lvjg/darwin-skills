# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/policy_loader"

class TimeoutGatewayTest < Minitest::Test
  Client = Struct.new(:result, :error) do
    def fetch_timeout
      raise error if error

      result
    end
  end

  def test_policy_uses_vendor_timeout
    loader = PolicyLoader.new(TimeoutGateway.new(Client.new(1200)))

    assert_equal({ timeout: 1200 }, loader.load)
  end

  def test_gateway_translates_vendor_failure
    gateway = TimeoutGateway.new(TimeoutGatewayTest::Client.new(nil, VendorTimeoutError.new("offline")))

    error = assert_raises(TimeoutUnavailable) { gateway.fetch }
    assert_equal "offline", error.message
  end
end
