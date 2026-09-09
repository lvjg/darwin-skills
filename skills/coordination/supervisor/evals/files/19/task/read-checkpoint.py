"""Bounded read-only checkpoint transport used by this recovery fixture."""
import argparse
from pathlib import Path
parser = argparse.ArgumentParser()
parser.add_argument('--start', type=int)
parser.add_argument('--count', type=int, default=80)
args = parser.parse_args()
lines = Path(__file__).with_name('checkpoint.md').read_text().splitlines()
if args.start is None:
    indexes = list(range(min(35, len(lines))))
    if len(lines) > 55:
        indexes += [None] + list(range(len(lines)-20, len(lines)))
    else:
        indexes += list(range(35, len(lines)))
else:
    if args.start < 1 or not 1 <= args.count <= 120:
        parser.error('start must be positive; count must be 1..120')
    indexes = range(args.start-1, min(args.start-1+args.count, len(lines)))
for i in indexes:
    if i is None:
        print(f'[OUTPUT TRUNCATED: omitted lines 36..{len(lines)-20}; total {len(lines)} lines. Read with --start N --count 80.]')
    else:
        print(f'{i+1}: {lines[i]}')
