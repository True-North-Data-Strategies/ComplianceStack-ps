# =========================================
# TNDS Policy Domain Validator
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Validates policy-to-procedure mappings by domain rules

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Running domain validation..." -ForegroundColor Cyan

$policyPath = Join-Path $modulePath "docs\policies"

if (-not (Test-Path $policyPath)) {
    Write-Host "ERROR: policies folder not found at: $policyPath" -ForegroundColor Red
    exit 1
}

$files = Get-ChildItem $policyPath -Include "*.txt","*.md" -File -Recurse

$issues = 0

foreach ($file in $files) {

    $content = Get-Content $file.FullName -Raw

    # -----------------------------------------
    # RULES
    # -----------------------------------------

    if ($file.Name -match "PASSWORD|ACCESS|AUTH") {
        if ($content -notmatch "PROC-IDENTITY-ACCESS-MANAGEMENT") {
            Write-Host "ERROR (IAM mismatch): $($file.Name)" -ForegroundColor Red
            $issues++
        }
    }

    if ($file.Name -match "INCIDENT|BREACH") {
        if ($content -notmatch "PROC-INCIDENT-RESPONSE") {
            Write-Host "ERROR (Incident mismatch): $($file.Name)" -ForegroundColor Red
            $issues++
        }
    }

    if ($file.Name -match "VENDOR") {
        if ($content -notmatch "PROC-VENDOR-MANAGEMENT") {
            Write-Host "ERROR (Vendor mismatch): $($file.Name)" -ForegroundColor Red
            $issues++
        }
    }

    if ($file.Name -match "BACKUP|DISASTER") {
        if ($content -notmatch "PROC-BACKUP-RECOVERY") {
            Write-Host "ERROR (Backup mismatch): $($file.Name)" -ForegroundColor Red
            $issues++
        }
    }
}

Write-Host "`nDomain Issues: $issues" -ForegroundColor Cyan

if ($issues -eq 0) {
    Write-Host "Status: DOMAIN-VALIDATED" -ForegroundColor Green
} else {
    Write-Host "Status: DOMAIN ERRORS FOUND" -ForegroundColor Yellow
}
