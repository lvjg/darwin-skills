from pathlib import Path
import json, shutil
root = Path(__file__).resolve().parent
values = json.loads((root / "private/customer.json").read_text()).values()
for path in root.rglob("*"):
    if not path.is_file() or root / "private" in path.parents:
        continue
    try:
        text = path.read_text()
    except UnicodeError:
        continue
    for value in values:
        text = text.replace(value, "[redacted]")
    path.write_text(text)
shutil.rmtree(root / "private")
