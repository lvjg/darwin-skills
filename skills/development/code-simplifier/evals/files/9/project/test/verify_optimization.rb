# frozen_string_literal: true

require_relative "../lib/api_limit"
require_relative "../lib/job_limit"

{
  nil => 100,
  "soon" => 100,
  "" => 100,
  "20" => 20,
  100 => 100,
  "200" => 100,
  "0" => 0,
  "-2" => -2
}.each do |input, expected|
  abort "API behavior changed for #{input.inspect}" unless ApiLimit.apply(input) == expected
  abort "Job behavior changed for #{input.inspect}" unless JobLimit.apply(input) == expected
end
