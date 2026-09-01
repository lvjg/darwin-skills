# frozen_string_literal: true

project_root = File.expand_path("..", __dir__)
policy_path = File.join(project_root, "lib/limit_policy.rb")
api_path = File.join(project_root, "lib/api_limit.rb")
job_path = File.join(project_root, "lib/job_limit.rb")

abort "shared limit policy is missing" unless File.exist?(policy_path)

policy = File.read(policy_path)
api = File.read(api_path)
job = File.read(job_path)

abort "LimitPolicy is missing" unless policy.include?("LimitPolicy")

{ "ApiLimit" => api, "JobLimit" => job }.each do |name, source|
  abort "#{name} entry contract is missing" unless source.include?("module #{name}") && source.include?("def self.apply")
  abort "#{name} does not delegate to LimitPolicy" unless source.include?("LimitPolicy.apply(requested)")
  abort "#{name} retains a duplicate limit decision" if source.match?(/MAXIMUM|Integer\(requested\)|rescue/)
end

require api_path
require job_path

{
  nil => 100,
  "soon" => 100,
  "20" => 20,
  "200" => 100
}.each do |input, expected|
  abort "shared policy behavior changed for #{input.inspect}" unless LimitPolicy.apply(input) == expected
  abort "API behavior changed for #{input.inspect}" unless ApiLimit.apply(input) == expected
  abort "Job behavior changed for #{input.inspect}" unless JobLimit.apply(input) == expected
end
