# Claude Skills Pack Installer (PowerShell)
# Usage: powershell -ExecutionPolicy Bypass -File .\install.ps1

$ScriptDir = $PSScriptRoot
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "Installing Claude Skills Pack..."

$CommandsDir = Join-Path $ClaudeDir "commands"
$AgentsDir = Join-Path $ClaudeDir "agents"
$SkillsDir = Join-Path $ClaudeDir "skills"

New-Item -Path $CommandsDir -ItemType Directory -Force | Out-Null
New-Item -Path $AgentsDir -ItemType Directory -Force | Out-Null
New-Item -Path $SkillsDir -ItemType Directory -Force | Out-Null

# Copy commands
$SourceCommands = Join-Path $ScriptDir "commands"
if (Test-Path $SourceCommands) {
    $CommandItems = Get-ChildItem -Path $SourceCommands -Force -File -ErrorAction SilentlyContinue
    if (@($CommandItems).Count -gt 0) {
        Copy-Item -Path (Join-Path $SourceCommands "*") -Destination $CommandsDir -Recurse -Force
        Write-Host "Commands installed: $($CommandItems.Count) files"
    }
}

# Copy agents
$SourceAgents = Join-Path $ScriptDir "agents"
if (Test-Path $SourceAgents) {
    $AgentItems = Get-ChildItem -Path $SourceAgents -Force -File -ErrorAction SilentlyContinue
    if (@($AgentItems).Count -gt 0) {
        Copy-Item -Path (Join-Path $SourceAgents "*") -Destination $AgentsDir -Recurse -Force
        Write-Host "Agents installed: $($AgentItems.Count) files"
    }
}

# Copy skills
$SourceSkills = Join-Path $ScriptDir "skills"
if (Test-Path $SourceSkills) {
    $SkillItems = Get-ChildItem -Path $SourceSkills -Force -Directory -ErrorAction SilentlyContinue
    if (@($SkillItems).Count -gt 0) {
        Copy-Item -Path (Join-Path $SourceSkills "*") -Destination $SkillsDir -Recurse -Force
        Write-Host "Skills installed: $($SkillItems.Count) folders"
    }
}

Write-Host ""
Write-Host "Installation complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Run /clear in Claude Code to reload"
Write-Host "  2. Test with /kehoach, /cook, /csp-backend, /csp-deploy, etc."
