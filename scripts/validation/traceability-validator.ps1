# =========================================
# TNDS Traceability Validator
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Checks policies for TBD references

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Running traceability validation..." -ForegroundColor Cyan

$policyPath = Join-Path $modulePath "docs\policies"

if (-not (Test-Path $policyPath)) {
    Write-Host "ERROR: policies folder not found at: $policyPath" -ForegroundColor Red
    exit 1
}

$files = Get-ChildItem $policyPath -Include "*.txt","*.md" -File -Recurse

$issues = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw

    if ($content -match "TBD") {
        Write-Host "INCOMPLETE: $($file.Name)" -ForegroundColor Yellow
        $issues++
    }
    else {
        Write-Host "OK: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "`nTraceability Issues: $issues" -ForegroundColor Cyan

if ($issues -eq 0) {
    Write-Host "Status: FULLY LINKED" -ForegroundColor Green
}
else {
    Write-Host "Status: NEEDS LINKING" -ForegroundColor Yellow
}
