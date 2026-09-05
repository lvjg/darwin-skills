# frozen_string_literal: true
# 隔离的本地 Preview Owner。start 的重复调用会创建第二个操作，便于检出重复副作用。
require "json"
state_path = File.join(__dir__, "operation.json")
command, argument = ARGV
abort "usage: operation.rb start <revision> | status <operation-id>" unless ARGV.length == 2 && %w[start status].include?(command)
state = JSON.parse(File.read(state_path))
if command == "start"
  state["start_count"] += 1
  operation_id = "preview-#{state.fetch('start_count')}"
  state.fetch("operations")[operation_id] = {
    "requested_revision" => argument, "status" => "running",
    "running_revision" => nil, "healthy" => false
  }
  File.write(state_path, JSON.pretty_generate(state) + "\n")
else
  operation_id = argument
  abort "unknown operation" unless state.fetch("operations").key?(operation_id)
end
puts JSON.generate({ "owner" => "local-preview", "operation_id" => operation_id }.merge(state.fetch("operations").fetch(operation_id)))
