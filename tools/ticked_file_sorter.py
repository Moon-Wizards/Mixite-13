#!/usr/bin/env python3

import functools
import os
import sys
from pathlib import Path

FILE_EXTENSIONS = ("dm", "dmf")
BEGIN_MARKER = "// BEGIN_INCLUDE"
END_MARKER = "// END_INCLUDE"

IGNORED_MARKERS = {
	"// NOVA EDIT START",
	"// NOVA EDIT END",
	"// M13 EDIT ADDITION START",
	"// M13 EDIT ADDITION END",
}

def red(text):
	return "\033[31m" + str(text) + "\033[0m"

def green(text):
	return "\033[32m" + str(text) + "\033[0m"

def fail(message):
	print(red(f"Include Sorter Error: {message}"))
	sys.exit(1)

def get_include_path(line):
	line = line.strip()
	prefix = '#include "'
	if not line.startswith(prefix) or not line.endswith('"'):
		fail(f"Unexpected line inside include block: {line}")
	return line[len(prefix):-1].lower()

def compare_include_lines(a, b):
	a_path = get_include_path(a)
	b_path = get_include_path(b)

	if a_path == b_path:
		fail(f"Duplicate include detected: {a_path}")

	a_suffix = a_path.split(".")[-1] if "." in a_path else ""
	b_suffix = b_path.split(".")[-1] if "." in b_path else ""

	a_segments = a_path.split("\\")
	b_segments = b_path.split("\\")

	for a_segment, b_segment in zip(a_segments, b_segments):
		a_is_file = a_segment.endswith(FILE_EXTENSIONS)
		b_is_file = b_segment.endswith(FILE_EXTENSIONS)

		if a_is_file and not b_is_file:
			return -1
		if b_is_file and not a_is_file:
			return 1

		if a_segment != b_segment:
			if a_suffix != b_suffix:
				return (a_suffix > b_suffix) - (a_suffix < b_suffix)
			return (a_segment > b_segment) - (a_segment < b_segment)

	fail(f"Could not distinguish include paths: {a_path} vs. {b_path}")

def main():
	if len(sys.argv) < 2:
		fail("No file specified. Usage: python sorter.py <file>")

	path = Path(sys.argv[1])
	if not path.is_file():
		fail(f"File does not exist: {path}")

	original_bytes = path.read_bytes()
	has_bom = original_bytes.startswith(b"\xef\xbb\xbf")

	try:
		content = original_bytes.decode("utf-8-sig" if has_bom else "utf-8")
	except UnicodeDecodeError as error:
		fail(f"Could not decode file as UTF-8: {error}")

	if "\r\n" in content:
		newline = "\r\n"
	elif "\r" in content:
		newline = "\r"
	else:
		newline = "\n"

	has_final_newline = content.endswith(("\n", "\r"))
	lines = content.splitlines()

	begin_index = -1
	end_index = -1

	for index, line in enumerate(lines):
		stripped = line.strip()
		if stripped == BEGIN_MARKER:
			if begin_index != -1:
				fail(f"Multiple {BEGIN_MARKER} markers found.")
			begin_index = index
		elif stripped == END_MARKER:
			if end_index != -1:
				fail(f"Multiple {END_MARKER} markers found.")
			end_index = index

	if begin_index == -1 or end_index == -1 or end_index <= begin_index:
		fail("Invalid or missing include markers.")

	positions = []
	includes = []

	for index in range(begin_index + 1, end_index):
		line = lines[index].strip()
		if line in IGNORED_MARKERS:
			continue
		if not line:
			fail(f"Blank line inside include block at line {index + 1}.")
		if not line.startswith("#include "):
			fail(f"Unexpected content at line {index + 1}: {line}")

		get_include_path(line)
		positions.append(index)
		includes.append(line)

	if not includes:
		print(green(f"Include Sorter: [{path}] No includes to sort."))
		return

	sorted_includes = sorted(includes, key=functools.cmp_to_key(compare_include_lines))

	if includes == sorted_includes:
		print(green(f"Include Sorter: [{path}] Includes are already in order."))
		return

	for position, include in zip(positions, sorted_includes):
		lines[position] = include

	output = newline.join(lines)
	if has_final_newline:
		output += newline

	output_bytes = output.encode("utf-8-sig" if has_bom else "utf-8")
	path.write_bytes(output_bytes)

	print(green(f"Include Sorter: [{path}] Successfully sorted include block."))

if __name__ == "__main__":
	main()
