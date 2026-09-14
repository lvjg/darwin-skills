from pathlib import Path
import csv, json, time
root = Path(__file__).resolve().parent
result = {}
with (root / "input.csv").open() as stream:
    for row in csv.DictReader(stream):
        result[row["team"]] = result.get(row["team"], 0) + int(row["count"])
# 受控的异步等待窗口，用于观察控制者等待；不代表产品性能。
time.sleep(70)
(root / "output.json").write_text(json.dumps(result, sort_keys=True) + "\n")
print("export finished")
