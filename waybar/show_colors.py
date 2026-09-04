#!/usr/bin/env python3
"""Read colors.css and print each color name with a colored sample block."""

import re
import sys

CSS_PATH = "colors.css"
BLOCK = "██████"
RESET = "\033[0m"


def hex_to_rgb(hex_color: str):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) for i in (0, 2, 4))


def ansi_fg(rgb: tuple[int, int, int]) -> str:
    return f"\033[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m"


def parse_colors(path: str):
    pattern = re.compile(r"@define-color\s+(\S+)\s+([#]?[0-9a-fA-F]+);")
    colors = []
    with open(path, "r") as f:
        for line in f:
            match = pattern.search(line)
            if match:
                name, hex_val = match.groups()
                colors.append((name, hex_val))
    return colors


def main():
    try:
        colors = parse_colors(CSS_PATH)
    except FileNotFoundError:
        print(f"Error: {CSS_PATH} not found.", file=sys.stderr)
        sys.exit(1)

    if not colors:
        print(f"No color definitions found in {CSS_PATH}.", file=sys.stderr)
        sys.exit(1)

    max_name_len = max(len(name) for name, _ in colors)

    for name, hex_val in colors:
        rgb = hex_to_rgb(hex_val)
        fg = ansi_fg(rgb)
        print(f"{name:<{max_name_len}}  {fg}{BLOCK}{RESET}  {hex_val}")


if __name__ == "__main__":
    main()
