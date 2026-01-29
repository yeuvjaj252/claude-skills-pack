# Claude Skills Pack Uninstaller (PowerShell)
# Usage: powershell -ExecutionPolicy Bypass -File .\uninstall.ps1

$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "Uninstalling Claude Skills Pack..."

$CommandsDir = Join-Path $ClaudeDir "commands"
if (Test-Path $CommandsDir) {
    Remove-Item -Path $CommandsDir -Recurse -Force
    Write-Host "Commands removed"
}

$AgentsDir = Join-Path $ClaudeDir "agents"
if (Test-Path $AgentsDir) {
    Remove-Item -Path $AgentsDir -Recurse -Force
    Write-Host "Agents removed"
}

$SkillsDir = Join-Path $ClaudeDir "skills"
if (Test-Path $SkillsDir) {
    Remove-Item -Path $SkillsDir -Recurse -Force
    Write-Host "Skills removed"
}

Write-Host ""
Write-Host "Uninstall complete!"
Write-Host "Run /clear in Claude Code to reload."
