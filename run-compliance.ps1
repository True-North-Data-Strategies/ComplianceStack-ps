# =========================================
# TNDS Compliance Runner
# =========================================
# Run all compliance checks against a module
# Usage: .\run-compliance.ps1 -modulePath "C:\path\to\compliance-gov-command"

param (
    [string]$modulePath
)

Write-Host "=== TNDS Compliance Command ===" -ForegroundColor Cyan

# Resolve root directory from script location
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SCRIPTS = Join-Path $root "scripts"

# If no modulePath passed, try to find one in current location
if (-not $modulePath) {
    # Check if we're inside a compliance-gov-command folder
    if (Test-Path (Join-Path (Get-Location) "docs\policies")) {
        $modulePath = (Get-Location).Path
    }
    else {
        Write-Host "ERROR: No -modulePath provided and current directory is not a compliance module." -ForegroundColor Red
        Write-Host "Usage: .\run-compliance.ps1 -modulePath 'C:\path\to\compliance-gov-command'" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "Module: $modulePath" -ForegroundColor Gray

# --- VALIDATION ---
Write-Host "`n[1/5] Validating..." -ForegroundColor Yellow
& (Join-Path $SCRIPTS "validation\validate-compliance-module.ps1") -modulePath $modulePath

# --- TRACEABILITY ---
Write-Host "`n[2/5] Traceability..." -ForegroundColor Yellow
& (Join-Path $SCRIPTS "validation\traceability-validator.ps1") -modulePath $modulePath

# --- DOMAIN CHECK ---
Write-Host "`n[3/5] Domain Check..." -ForegroundColor Yellow
& (Join-Path $SCRIPTS "validation\policy-domain-validator.ps1") -modulePath $modulePath

# --- REMEDIATION ---
Write-Host "`n[4/5] Remediation..." -ForegroundColor Yellow
& (Join-Path $SCRIPTS "reporting\remediation-engine.ps1") -modulePath $modulePath

# --- REPORT ---
Write-Host "`n[5/5] Report..." -ForegroundColor Yellow
& (Join-Path $SCRIPTS "reporting\generate-compliance-report.ps1") -modulePath $modulePath

Write-Host "`n=== COMPLETE ===" -ForegroundColor Green
