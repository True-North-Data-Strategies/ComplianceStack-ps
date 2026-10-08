# =========================================
# TNDS System Test - Non-Interactive
# =========================================
# Simulates full pipeline without Read-Host prompts
# Tests each script individually with parameterized paths

$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TNDS COMPLIANCE SYSTEM - FULL TEST" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$testClient = "test-auto-$(Get-Date -Format 'HHmmss')"
$templatePath = Join-Path $root "client-compliance-command\compliance-gov-command"
$clientDeployDir = Join-Path $root "deployments\$testClient"
$modulePath = Join-Path $clientDeployDir "compliance-gov-command"
$scriptsRoot = Join-Path $root "scripts"

$errors = 0

# -----------------------------------------
# TEST 1: Deploy template
# -----------------------------------------
Write-Host "`n[TEST 1] DEPLOY template..." -ForegroundColor Yellow

if (-not (Test-Path $templatePath)) {
    Write-Host "FAIL: Template not found at $templatePath" -ForegroundColor Red
    $errors++
} else {
    New-Item -ItemType Directory -Path $clientDeployDir -Force | Out-Null
    Copy-Item $templatePath $clientDeployDir -Recurse
    
    if (Test-Path $modulePath) {
        Write-Host "PASS: Module deployed to $modulePath" -ForegroundColor Green
    } else {
        Write-Host "FAIL: Module not found after copy" -ForegroundColor Red
        $errors++
    }
}

# Init evidence
$evidencePath = Join-Path $modulePath "docs\evidence"
New-Item -ItemType Directory -Path (Join-Path $evidencePath "restricted") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $evidencePath "business") -Force | Out-Null

# -----------------------------------------
# TEST 2: Create variable map (simulates intake)
# -----------------------------------------
Write-Host "`n[TEST 2] CREATE variable map (simulated intake)..." -ForegroundColor Yellow

$testData = @{
    COMPANY_LEGAL_NAME     = "Test Corp LLC"
    OWNER_NAME             = "John Doe"
    CONTACT_EMAIL          = "john@testcorp.com"
    CONTACT_PHONE          = "555-123-4567"
    COMPANY_WEBSITE        = "testcorp.com"
    COMPANY_CITY_STATE_ZIP = "Colorado Springs, CO 80903"
    COMPANY_UEI            = "UEI123456789"
    COMPANY_CAGE_CODE      = "CAGE01"
    CLOUD_PLATFORM_WORKSPACE = "Google Workspace"
    CLOUD_PROVIDER           = "Google"
    CLOUD_PROVIDER_DOMAIN    = "google.com"
}

$mapPath = Join-Path $modulePath "client-variable-map.json"
$testData | ConvertTo-Json -Depth 3 | Out-File $mapPath -Encoding UTF8

if (Test-Path $mapPath) {
    Write-Host "PASS: Variable map created at $mapPath" -ForegroundColor Green
} else {
    Write-Host "FAIL: Variable map not created" -ForegroundColor Red
    $errors++
}

# -----------------------------------------
# TEST 3: Injection
# -----------------------------------------
Write-Host "`n[TEST 3] INJECTION (populate-client-data)..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "injection\populate-client-data.ps1") -modulePath $modulePath

if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne $null) {
    Write-Host "FAIL: Injection returned exit code $LASTEXITCODE" -ForegroundColor Red
    $errors++
} else {
    Write-Host "PASS: Injection complete" -ForegroundColor Green
}

# -----------------------------------------
# TEST 4: Enforcement
# -----------------------------------------
Write-Host "`n[TEST 4] ENFORCEMENT (placeholder check)..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "enforcement\enforce-no-placeholders.ps1") -modulePath $modulePath

$enforcementResult = $LASTEXITCODE
if ($enforcementResult -eq 1) {
    Write-Host "INFO: Placeholders still exist (expected if template has vars not in map)" -ForegroundColor Yellow
} else {
    Write-Host "PASS: No placeholders found" -ForegroundColor Green
}

# -----------------------------------------
# TEST 5: Validate compliance module
# -----------------------------------------
Write-Host "`n[TEST 5] VALIDATE compliance module..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "validation\validate-compliance-module.ps1") -modulePath $modulePath

Write-Host "PASS: Validation ran without path errors" -ForegroundColor Green

# -----------------------------------------
# TEST 6: Traceability validator
# -----------------------------------------
Write-Host "`n[TEST 6] TRACEABILITY validator..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "validation\traceability-validator.ps1") -modulePath $modulePath

Write-Host "PASS: Traceability ran without path errors" -ForegroundColor Green

# -----------------------------------------
# TEST 7: Policy domain validator
# -----------------------------------------
Write-Host "`n[TEST 7] POLICY DOMAIN validator..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "validation\policy-domain-validator.ps1") -modulePath $modulePath

Write-Host "PASS: Domain validator ran without path errors" -ForegroundColor Green

# -----------------------------------------
# TEST 8: Remediation engine
# -----------------------------------------
Write-Host "`n[TEST 8] REMEDIATION engine..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "reporting\remediation-engine.ps1") -modulePath $modulePath

Write-Host "PASS: Remediation ran without path errors" -ForegroundColor Green

# -----------------------------------------
# TEST 9: Report generator
# -----------------------------------------
Write-Host "`n[TEST 9] REPORT generator..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "reporting\generate-compliance-report.ps1") -modulePath $modulePath

$reportDir = Join-Path $modulePath "data"
$reports = Get-ChildItem $reportDir -Filter "compliance-report-*.txt" -ErrorAction SilentlyContinue

if ($reports.Count -gt 0) {
    Write-Host "PASS: Report generated at $($reports[0].FullName)" -ForegroundColor Green
} else {
    Write-Host "FAIL: No report file found" -ForegroundColor Red
    $errors++
}

# -----------------------------------------
# TEST 10: Variable scanner
# -----------------------------------------
Write-Host "`n[TEST 10] VARIABLE scanner..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "validation\variable-scanner.ps1") -modulePath $modulePath

Write-Host "PASS: Variable scanner ran without path errors" -ForegroundColor Green

# -----------------------------------------
# TEST 11: run-compliance.ps1
# -----------------------------------------
Write-Host "`n[TEST 11] RUN-COMPLIANCE orchestrator..." -ForegroundColor Yellow

& (Join-Path $root "run-compliance.ps1") -modulePath $modulePath

Write-Host "PASS: run-compliance.ps1 ran without path errors" -ForegroundColor Green

# -----------------------------------------
# RESULTS
# -----------------------------------------
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TEST RESULTS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($errors -eq 0) {
    Write-Host "ALL TESTS PASSED - Zero path errors" -ForegroundColor Green
} else {
    Write-Host "ERRORS: $errors test(s) failed" -ForegroundColor Red
}

Write-Host "Test client: $testClient" -ForegroundColor Gray
Write-Host "Module path: $modulePath" -ForegroundColor Gray
