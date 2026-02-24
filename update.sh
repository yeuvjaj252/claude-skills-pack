#!/bin/bash

# Claude Skills Pack Updater
# Usage: ./update.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🔄 Updating Claude Skills Pack..."

# Ensure target directories exist
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"

# Cleanup legacy command names that were renamed
LEGACY_COMMANDS=(
  "backend.md"
  "brainstorm.md"
  "create.md"
  "database.md"
  "debug.md"
  "deploy.md"
  "devops.md"
  "docs.md"
  "enhance.md"
  "explore.md"
  "frontend.md"
  "mobile.md"
  "orchestrate.md"
  "performance.md"
  "plan.md"
  "preview.md"
  "security.md"
  "status.md"
  "test.md"
  "ui.md"
  "ui-ux-pro-max.md"
)

for cmd in "${LEGACY_COMMANDS[@]}"; do
  if [ -f "$CLAUDE_DIR/commands/$cmd" ]; then
    rm -f "$CLAUDE_DIR/commands/$cmd"
    echo "🧹 Removed legacy command: $cmd"
  fi
done

# Sync commands
if [ -d "$SCRIPT_DIR/commands" ] && [ "$(ls -A $SCRIPT_DIR/commands 2>/dev/null)" ]; then
  cp -r "$SCRIPT_DIR/commands"/* "$CLAUDE_DIR/commands/"
  echo "✅ Commands updated: $(ls -1 $SCRIPT_DIR/commands | wc -l) files"
fi

# Sync agents
if [ -d "$SCRIPT_DIR/agents" ] && [ "$(ls -A $SCRIPT_DIR/agents 2>/dev/null)" ]; then
  cp -r "$SCRIPT_DIR/agents"/* "$CLAUDE_DIR/agents/"
  echo "✅ Agents updated: $(ls -1 $SCRIPT_DIR/agents | wc -l) files"
fi

# Sync skills
if [ -d "$SCRIPT_DIR/skills" ] && [ "$(ls -A $SCRIPT_DIR/skills 2>/dev/null)" ]; then
  cp -r "$SCRIPT_DIR/skills"/* "$CLAUDE_DIR/skills/"
  echo "✅ Skills updated: $(ls -1 $SCRIPT_DIR/skills | wc -l) folders"
fi

echo ""
echo "🎉 Update complete!"
echo ""
echo "Next steps:"
echo "  1. Run /clear in Claude Code to reload"
echo "  2. Test with /kehoach, /cook, /csp-backend, /csp-deploy, etc."
echo ""
echo "Migration notes:"
echo "  - /plan -> /kehoach"
echo "  - /create -> /cook"
echo "  - Core commands moved to /csp-* namespace"
