#!/bin/bash

# Claude Skills Pack Blinko-only Installer
# Usage: ./install-blinko.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILL_NAME="skill-csp-blinko-knowledge-capture"
SOURCE_SKILL_DIR="$SCRIPT_DIR/skills/$SKILL_NAME"
TARGET_SKILL_DIR="$CLAUDE_DIR/skills/$SKILL_NAME"

echo "Installing $SKILL_NAME..."

if [ ! -d "$SOURCE_SKILL_DIR" ]; then
    echo "Source skill not found: $SOURCE_SKILL_DIR" >&2
    exit 1
fi

mkdir -p "$CLAUDE_DIR/skills"
rm -rf "$TARGET_SKILL_DIR"
cp -r "$SOURCE_SKILL_DIR" "$TARGET_SKILL_DIR"

echo "Installed: $TARGET_SKILL_DIR"
echo ""
echo "Next steps:"
echo "  1. Run /clear in Claude Code to reload"
echo "  2. Use the Blinko workflow command or load $SKILL_NAME"
