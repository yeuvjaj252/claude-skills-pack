# Claude Skills Pack Blinko-only Installer (PowerShell)
# Usage: powershell -ExecutionPolicy Bypass -File .\install-blinko.ps1

$ScriptDir = $PSScriptRoot
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$SkillName = "skill-csp-blinko-knowledge-capture"
$SourceSkillDir = Join-Path (Join-Path $ScriptDir "skills") $SkillName
$TargetSkillsDir = Join-Path $ClaudeDir "skills"
$TargetSkillDir = Join-Path $TargetSkillsDir $SkillName

Write-Host "Installing $SkillName..."

if (-not (Test-Path $SourceSkillDir)) {
    Write-Error "Source skill not found: $SourceSkillDir"
    exit 1
}

New-Item -Path $TargetSkillsDir -ItemType Directory -Force | Out-Null

if (Test-Path $TargetSkillDir) {
    Remove-Item -Path $TargetSkillDir -Recurse -Force
}

Copy-Item -Path $SourceSkillDir -Destination $TargetSkillDir -Recurse -Force

Write-Host "Installed: $TargetSkillDir"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Run /clear in Claude Code to reload"
Write-Host "  2. Use the Blinko workflow command or load $SkillName"
