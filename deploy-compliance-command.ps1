# =========================================
# TNDS Compliance Command Deployment Script
# =========================================

param (
    [string]$TargetPath
)

if (-not $TargetPath) {
    Write-Host "Usage: .\deploy-compliance-command.ps1 -TargetPath C:\Users\truenorth\dev\TNDS-Command-Center" -ForegroundColor Yellow
    exit
}

$source = ".\compliance-gov-command"
$destination = Join-Path $TargetPath "apps\commands-system\compliance-gov-command"

Write-Host "Deploying TNDS Compliance Command..." -ForegroundColor Cyan
Write-Host "Source: $source" -ForegroundColor DarkGray
Write-Host "Destination: $destination" -ForegroundColor DarkGray

if (-not (Test-Path $source)) {
    Write-Host "ERROR: Source path not found: $source" -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Path $destination -Force | Out-Null
Copy-Item $source\* $destination -Recurse -Force

Write-Host "Deployment complete to: $destination" -ForegroundColor Green