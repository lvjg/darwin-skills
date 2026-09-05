# frozen_string_literal: true

require "fileutils"
require "json"
require "minitest/autorun"
require "open3"
require "rbconfig"
require "tmpdir"

# Exercise the real entrypoint with a local Skill-Up stand-in, without a model,
# credentials, network, or test-only branches in the runner.
class RunEvalsTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  MOCK = <<~'MOCK_RUBY'
    #!/usr/bin/env ruby
    require "fileutils"
    require "json"
    require "yaml"
    scenario = ENV.fetch("RUNNER_TEST_SCENARIO")
    exit 0 if scenario == "stale"
    config = YAML.load_file(ARGV.fetch(1))
    output = ARGV.fetch(ARGV.index("--output-dir") + 1)
    File.write(File.join(output, "actor-skills.json"), config.fetch("skills").to_json)
    case_file = config.fetch("cases").fetch("files").find { |path| path.end_with?("/case-17.yaml") }
    item = YAML.load_file(case_file)
    File.write(File.join(output, "materialized-case.json"), JSON.pretty_generate(item))
    iterations = scenario == "iterations" ? [1, 2] : [1]
    iterations.each do |iteration|
      base = File.join(output, "iteration-#{iteration}")
      directory = File.join(base, "case-17/with_skill")
      run = File.join(directory, "outputs/agent/run")
      FileUtils.mkdir_p(run)
      item.fetch("collect_artifacts").each do |relative|
        next if scenario == "missing" && relative.end_with?("checkpoint.md")
        content = item.fetch("context").fetch("files").fetch(relative)
        if (scenario == "bad-markdown" || (scenario == "iterations" && iteration == 2)) && relative.end_with?("checkpoint.md")
          content = "state: Complete\n"
        end
        content = "\xFF" if scenario == "invalid-bytes" && relative.end_with?("checkpoint.md")
        path = File.join(directory, "outputs/workspace", relative)
        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, content)
      end
      message = scenario == "encrypted" ? "gAAAAencrypted-runtime-handoff" : "Read the specified Owner interface; query only. Do not read checkpoint."
      fork_turns = scenario == "unbounded" ? "all" : "none"
      events = [
        {type: "function_call", namespace: "collaboration", name: "spawn_agent", call_id: "spawn", arguments: {message: message, fork_turns: fork_turns}.to_json},
        {type: "function_call_output", call_id: "spawn", output: {task_name: "/root/worker"}.to_json},
        {type: "function_call", namespace: "collaboration", name: "wait_agent", call_id: "wait", arguments: "{}"},
        {type: "function_call_output", call_id: "wait", output: {timed_out: false}.to_json},
        {type: "agent_message", author: "/root/worker", content: [{type: "input_text", text: "Message Type: FINAL_ANSWER\nTask name: /root\nSender: /root/worker\nPayload:\nOwner result"}]}
      ]
      File.write(File.join(run, "rollout-test.jsonl"), events.map { |payload| {type: "response_item", payload: payload}.to_json }.join("\n") + "\n")
      status = scenario == "judge-fail" ? "FAIL" : "PASS"
      assertion = {text: "model criterion", passed: status == "PASS", evidence: "local test double"}
      row = {case_id: "case-17", configuration: "with_skill", status: status, grading: {status: status, assertion_results: [assertion]}}
      result = {skill_name: "supervisor", case_results: [row]}
      %w[result.json report.json].each { |name| File.write(File.join(base, name), result.to_json) }
      File.write(File.join(base, "benchmark.json"), {upstream_only: true}.to_json)
      File.write(File.join(base, "benchmark.md"), "upstream summary\n")
      File.write(File.join(directory, "grading.json"), {expectations: [assertion], summary: {}, judge_context: {preserved: true}}.to_json)
    end
    exit(scenario == "judge-fail" || scenario == "process-error" ? 1 : 0)
  MOCK_RUBY

  def setup
    @temporary = Dir.mktmpdir("supervisor-runner-test-")
    @mock = File.join(@temporary, "skill-up")
    File.write(@mock, MOCK)
    FileUtils.chmod(0o755, @mock)
    @output = File.join(@temporary, "output")
  end

  def teardown
    FileUtils.remove_entry(@temporary)
  end

  def run_scenario(scenario)
    @stdout, @stderr, @exit = Open3.capture3(
      { "RUNNER_TEST_SCENARIO" => scenario }, RbConfig.ruby, File.join(ROOT, "evals/run-evals"),
      "--skill-up", @mock, "--model", "local-test-double", "--case", "case-17", "--output-root", @output,
      "supervisor", chdir: ROOT
    )
  end

  def iteration_path(iteration = 1)
    File.join(@output, "supervisor", "iteration-#{iteration}")
  end

  def read_json(path)
    JSON.parse(File.read(path))
  end

  def assert_final(status, iteration = 1)
    base = iteration_path(iteration)
    result = read_json(File.join(base, "result.json"))
    assert_equal status, result.fetch("case_results").first.fetch("status"), @stderr
    assert_equal result, read_json(File.join(base, "report.json"))
    grading = read_json(File.join(base, "case-17/with_skill/grading.json"))
    assert_equal status, grading.fetch("status")
    assert_equal result.fetch("case_results").first.fetch("grading").fetch("assertion_results"), grading.fetch("expectations")
    assert_equal grading.fetch("summary"), result.fetch("case_results").first.fetch("grading").fetch("summary")
    assert_equal grading.fetch("expectations").length, grading.fetch("summary").fetch("total")
    assert_equal grading.fetch("expectations").count { |item| item.fetch("passed") }, grading.fetch("summary").fetch("passed")
    assert grading.fetch("judge_context").fetch("preserved")
    assert File.file?(File.join(base, "skill-up/result.json"))
    refute File.exist?(File.join(base, "benchmark.json"))
    assert File.file?(File.join(base, "skill-up/benchmark.json"))
  end

  def test_pass_keeps_verdicts_consistent_and_collects_real_fixture_bytes
    run_scenario("pass")
    assert @exit.success?, @stderr
    assert_final("PASS")
    item = read_json(File.join(@output, "supervisor/materialized-case.json"))
    assert_equal File.join(ROOT, "evals/judge-evidence"), item.fetch("judge").fetch("skills").first.fetch("path")
    assert_equal ".agents/skills/judge-evidence", item.fetch("judge").fetch("skills").first.fetch("target")
    refute read_json(File.join(@output, "supervisor/actor-skills.json")).any? { |skill| skill.fetch("path") == File.join(ROOT, "evals/judge-evidence") }
    %w[operation.json operation.rb checkpoint.md root-intent.md].each do |name|
      relative = "evals/files/17/task/#{name}"
      assert_includes item.fetch("collect_artifacts"), relative
      assert_equal File.binread(File.join(ROOT, "skills/supervisor", relative)),
                   File.binread(File.join(iteration_path, "case-17/with_skill/outputs/workspace", relative))
    end
  end

  def test_program_failure_overrides_model_pass_in_every_final_report
    run_scenario("bad-markdown")
    refute @exit.success?
    assert_final("FAIL")
    assert_equal "PASS", read_json(File.join(iteration_path, "skill-up/result.json")).fetch("case_results").first.fetch("status")
  end

  def test_unreadable_handoff_is_evidence_unavailable
    run_scenario("encrypted")
    refute @exit.success?
    assert_final("ERROR")
    assert_includes @stderr, "证据不可用"
  end

  def test_missing_artifact_is_evidence_unavailable
    run_scenario("missing")
    refute @exit.success?
    assert_final("ERROR")
  end

  def test_invalid_artifact_bytes_fail_without_leaving_a_passing_report
    run_scenario("invalid-bytes")
    refute @exit.success?
    assert_final("FAIL")
  end

  def test_known_unbounded_context_is_a_behavior_failure
    run_scenario("unbounded")
    refute @exit.success?
    assert_final("FAIL")
  end

  def test_program_checks_run_even_after_judge_failure
    run_scenario("judge-fail")
    refute @exit.success?
    assert_final("FAIL")
    assertions = read_json(File.join(iteration_path, "result.json")).fetch("case_results").first.fetch("grading").fetch("assertion_results")
    assert assertions.any? { |item| item.fetch("text") == "[runner-worker-roundtrip]" && item.fetch("passed") }
    refute assertions.first.fetch("passed")
  end

  def test_failed_process_cannot_leave_a_passing_report
    run_scenario("process-error")
    refute @exit.success?
    assert_final("ERROR")
  end

  def test_previous_report_is_not_reused_as_a_fresh_pass
    run_scenario("pass")
    path = File.join(iteration_path, "result.json")
    before = File.binread(path)
    run_scenario("stale")
    refute @exit.success?
    assert_includes @stderr, "不使用旧报告"
    assert_equal before, File.binread(path)
  end

  def test_each_iteration_uses_its_own_artifacts
    run_scenario("iterations")
    refute @exit.success?
    assert_final("PASS", 1)
    assert_final("FAIL", 2)
  end
end
