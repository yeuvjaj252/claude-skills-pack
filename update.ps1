# Claude Skills Pack Updater (PowerShell)
# Usage: powershell -ExecutionPolicy Bypass -File .\update.ps1

$ScriptDir = $PSScriptRoot
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "Updating Claude Skills Pack..."

# Try to sync latest source from GitHub when running inside a git clone
$GitFolder = Join-Path $ScriptDir ".git"
$HasGit = Get-Command git -ErrorAction SilentlyContinue
if ($HasGit -and (Test-Path $GitFolder)) {
  git -C $ScriptDir remote get-url origin *> $null
  if ($LASTEXITCODE -eq 0) {
    Write-Host "Syncing source from GitHub..."
    git -C $ScriptDir pull --ff-only *> $null
    if ($LASTEXITCODE -eq 0) {
      Write-Host "Source synced from GitHub"
    }
    else {
      Write-Host "Could not sync from GitHub (local changes or network issue)."
      Write-Host "Continuing with current local files."
    }
  }
  else {
    Write-Host "No origin remote found. Continuing with local files."
  }
}
else {
  Write-Host "Git repository not detected. Continuing with local files."
}

$CommandsDir = Join-Path $ClaudeDir "commands"
$AgentsDir = Join-Path $ClaudeDir "agents"
$SkillsDir = Join-Path $ClaudeDir "skills"

New-Item -Path $CommandsDir -ItemType Directory -Force | Out-Null
New-Item -Path $AgentsDir -ItemType Directory -Force | Out-Null
New-Item -Path $SkillsDir -ItemType Directory -Force | Out-Null

# Cleanup legacy command names that were renamed
$LegacyCommands = @(
  "backend.md",
  "brainstorm.md",
  "create.md",
  "database.md",
  "debug.md",
  "deploy.md",
  "devops.md",
  "docs.md",
  "enhance.md",
  "explore.md",
  "frontend.md",
  "mobile.md",
  "orchestrate.md",
  "performance.md",
  "plan.md",
  "preview.md",
  "security.md",
  "status.md",
  "test.md",
  "ui.md",
  "ui-ux-pro-max.md",
  "kehoach.md"
)

foreach ($cmd in $LegacyCommands) {
  $legacyPath = Join-Path $CommandsDir $cmd
  if (Test-Path $legacyPath) {
    Remove-Item -Path $legacyPath -Force
    Write-Host "Removed legacy command: $cmd"
  }
}

# Sync commands
$SourceCommands = Join-Path $ScriptDir "commands"
if (Test-Path $SourceCommands) {
  $CommandItems = Get-ChildItem -Path $SourceCommands -Force -File -ErrorAction SilentlyContinue
  if (@($CommandItems).Count -gt 0) {
    Copy-Item -Path (Join-Path $SourceCommands "*") -Destination $CommandsDir -Recurse -Force
    Write-Host "Commands updated: $($CommandItems.Count) files"
  }
}

# Sync agents
$SourceAgents = Join-Path $ScriptDir "agents"
if (Test-Path $SourceAgents) {
  $AgentItems = Get-ChildItem -Path $SourceAgents -Force -File -ErrorAction SilentlyContinue
  if (@($AgentItems).Count -gt 0) {
    Copy-Item -Path (Join-Path $SourceAgents "*") -Destination $AgentsDir -Recurse -Force
    Write-Host "Agents updated: $($AgentItems.Count) files"
  }
}

# Sync skills
$SourceSkills = Join-Path $ScriptDir "skills"
if (Test-Path $SourceSkills) {
  $SkillItems = Get-ChildItem -Path $SourceSkills -Force -Directory -ErrorAction SilentlyContinue
  if (@($SkillItems).Count -gt 0) {
    Copy-Item -Path (Join-Path $SourceSkills "*") -Destination $SkillsDir -Recurse -Force
    Write-Host "Skills updated: $($SkillItems.Count) folders"
  }
}

Write-Host ""
Write-Host "Update complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Run /clear in Claude Code to reload"
Write-Host "  2. Test with /csp-plan, /cook, /csp-backend, /csp-deploy, etc."
Write-Host ""
Write-Host "Migration notes:"
Write-Host "  - /plan -> /csp-plan"
Write-Host "  - /create -> /cook"
Write-Host "  - Core commands moved to /csp-* namespace"
