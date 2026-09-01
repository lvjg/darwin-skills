# frozen_string_literal: true

require "json"

class PolicyConfigError < StandardError; end

module PolicyConfig
  def self.mode(_project_root)
    "advisory"
  end
end
