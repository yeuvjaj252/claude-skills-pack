#!/bin/bash

# Claude Skills Pack Updater
# Usage: ./update.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🔄 Updating Claude Skills Pack..."

# Try to sync latest source from GitHub when running inside a git clone
if command -v git >/dev/null 2>&1 && [ -d "$SCRIPT_DIR/.git" ]; then
  if git -C "$SCRIPT_DIR" remote get-url origin >/dev/null 2>&1; then
    echo "📡 Syncing source from GitHub..."
    if git -C "$SCRIPT_DIR" pull --ff-only; then
      echo "✅ Source synced from GitHub"
    else
      echo "⚠️  Could not sync from GitHub (local changes or network issue)."
      echo "ℹ️  Continuing with current local files."
    fi
  else
    echo "ℹ️  No origin remote found. Continuing with local files."
  fi
else
  echo "ℹ️  Git repository not detected. Continuing with local files."
fi

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
  "kehoach.md"
)

for cmd in "${LEGACY_COMMANDS[@]}"; do
  if [ -f "$CLAUDE_DIR/commands/$cmd" ]; then
    rm -f "$CLAUDE_DIR/commands/$cmd"
    echo "🧹 Removed legacy command: $cmd"
  fi
done

# Cleanup legacy skill names (renamed to skill-csp-* prefix)
LEGACY_SKILLS=(
  "api-patterns"
  "app-builder"
  "architecture"
  "bash-linux"
  "behavioral-modes"
  "brainstorming"
  "clean-code"
  "cloudflare-expert"
  "code-review-checklist"
  "database-design"
  "deployment-procedures"
  "docker-expert"
  "documentation-templates"
  "frontend-design"
  "game-development"
  "geo-fundamentals"
  "i18n-localization"
  "intelligent-routing"
  "lint-and-validate"
  "mcp-builder"
  "mobile-design"
  "nestjs-expert"
  "nextjs-best-practices"
  "nextjs-react-expert"
  "nodejs-best-practices"
  "parallel-agents"
  "performance-profiling"
  "plan-writing"
  "powershell-windows"
  "prisma-expert"
  "prompt-leverage"
  "python-patterns"
  "react-patterns"
  "red-team-tactics"
  "rust-pro"
  "seo-fundamentals"
  "server-management"
  "systematic-debugging"
  "tailwind-patterns"
  "tdd-workflow"
  "testing-patterns"
  "typescript-expert"
  "ui-ux-pro-max"
  "vue-expert"
  "vulnerability-scanner"
  "web-design-guidelines"
  "webapp-testing"
)

for skill in "${LEGACY_SKILLS[@]}"; do
  if [ -d "$CLAUDE_DIR/skills/$skill" ]; then
    rm -rf "$CLAUDE_DIR/skills/$skill"
    echo "🧹 Removed legacy skill: $skill"
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
echo "  2. Test with /csp-plan, /cook, /csp-backend, /csp-deploy, etc."
echo ""
echo "Migration notes:"
echo "  - /plan -> /csp-plan"
echo "  - /create -> /cook"
echo "  - Core commands moved to /csp-* namespace"
