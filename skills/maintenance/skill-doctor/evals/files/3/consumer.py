from pathlib import Path
import json

# 常驻读者会在发布过程中读取同一个正式路径；必须看到完整旧版或完整新版。
def current_manifest(path):
    return json.loads(Path(path).read_text())
