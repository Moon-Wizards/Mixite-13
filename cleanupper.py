import os
import re
import sys

if len(sys.argv) < 2:
    print(f"usage: {sys.argv[0]} <file.dme>")
    sys.exit(1)

dme = sys.argv[1]
base_dir = os.path.dirname(os.path.abspath(dme))

include_re = re.compile(r'^(\s*)#include\s+"([^"]+)"')

with open(dme, "r", encoding="utf-8") as f:
    lines = f.readlines()

changed = 0

for i, line in enumerate(lines):
    match = include_re.match(line)
    if not match:
        continue

    indent, include_path = match.groups()

    # DME paths use backslashes, but Python's filesystem APIs
    # need the native separator on the current OS.
    include_path = include_path.replace("\\", os.sep)
    full_path = os.path.join(base_dir, include_path)

    if not os.path.isfile(full_path):
        lines[i] = indent + "// " + line[len(indent):].rstrip() + " // M13 REMOVAL\n"
        print(f"Missing: {include_path}")
        changed += 1

with open(dme, "w", encoding="utf-8", newline="") as f:
    f.writelines(lines)

print(f"Commented out {changed} missing include(s).")
