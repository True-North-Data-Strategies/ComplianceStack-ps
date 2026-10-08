# =========================================
# SIMPLE TNDS COMMAND DEPLOY
# =========================================

param (
    [Parameter(Mandatory=$true)]
    [string]$CommandName,

    [Parameter(Mandatory=$true)]
    [string]$TargetRoot
)

# SOURCE = current commands-system folder
$source = Join-Path (Get-Location) $CommandName

# DESTINATION = target project
$destination = Join-Path $TargetRoot "apps\commands-system\$CommandName"

Write-Host "Deploying: $CommandName" -ForegroundColor Cyan
Write-Host "Source: $source" -ForegroundColor DarkGray
Write-Host "Destination: $destination" -ForegroundColor DarkGray

# Validate source exists
if (-not (Test-Path $source)) {
    Write-Host "ERROR: Source not found: $source" -ForegroundColor Red
    exit 1
}

# Create destination
New-Item -ItemType Directory -Path $destination -Force | Out-Null

# Copy files
Copy-Item "$source\*" $destination -Recurse -Force

Write-Host "Deployment complete." -ForegroundColor Green