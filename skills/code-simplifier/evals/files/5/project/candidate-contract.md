# Candidate contract

The candidate adds the required report formatter plus a registry, YAML configuration and a registry-only test.

- The decided behavior is `ReportFormatter.call("sales", 3) == "sales: 3"`.
- The application calls `ReportFormatter` directly.
- No runtime path loads `ReportRegistry` or `config/reporting.yml`.
- No plugin, dynamic selection, public compatibility or future-extension obligation exists.
- Remove every unsupported candidate surface and its direct test consequence without changing formatter behavior.
- Do not replace the registry with another registration mechanism.

Run `ruby test/verify_cleanup.rb` from the project directory.
