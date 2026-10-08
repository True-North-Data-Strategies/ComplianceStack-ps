# =========================================
# TNDS Command System - Test Runner
# =========================================

Write-Host "Starting Command System Tests..." -ForegroundColor Cyan

# Root path (commands-system)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# Find all *-tests.gs files
$testFiles = Get-ChildItem -Path $root -Recurse -Filter "*-tests.gs"

if ($testFiles.Count -eq 0) {
    Write-Host "No test files found." -ForegroundColor Yellow
    return
}

foreach ($file in $testFiles) {
    Write-Host "Found test file: $($file.FullName)" -ForegroundColor Green
}

Write-Host "`nNOTE:" -ForegroundColor Yellow
Write-Host "Apps Script tests must be executed inside Google Apps Script runtime." -ForegroundColor Yellow
Write-Host "This script only discovers and validates test structure." -ForegroundColor Yellow

Write-Host "`nTest discovery complete." -ForegroundColor Cyan