# Claude Skills Pack Uninstaller (PowerShell)
# Usage: powershell -ExecutionPolicy Bypass -File .\uninstall.ps1

$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "Uninstalling Claude Skills Pack..."

# Remove CSP commands only
$CommandsDir = Join-Path $ClaudeDir "commands"
if (Test-Path $CommandsDir) {
    Get-ChildItem -Path $CommandsDir -Filter "csp-*.md" | Remove-Item -Force
    $cookFile = Join-Path $CommandsDir "cook.md"
    if (Test-Path $cookFile) { Remove-Item -Path $cookFile -Force }
    Write-Host "CSP commands removed"
}

# Remove CSP agents only
$AgentsDir = Join-Path $ClaudeDir "agents"
if (Test-Path $AgentsDir) {
    Get-ChildItem -Path $AgentsDir -Filter "*.md" | Remove-Item -Force
    Write-Host "CSP agents removed"
}

# Remove CSP skills only (skill-csp-* prefix)
$SkillsDir = Join-Path $ClaudeDir "skills"
if (Test-Path $SkillsDir) {
    Get-ChildItem -Path $SkillsDir -Directory -Filter "skill-csp-*" | Remove-Item -Recurse -Force
    $docFile = Join-Path $SkillsDir "doc.md"
    if (Test-Path $docFile) { Remove-Item -Path $docFile -Force }
    Write-Host "CSP skills removed"
}

Write-Host ""
Write-Host "Uninstall complete!"
Write-Host "Run /clear in Claude Code to reload."
