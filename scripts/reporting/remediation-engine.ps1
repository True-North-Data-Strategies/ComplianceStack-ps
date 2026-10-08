# =========================================
# TNDS Compliance Remediation Engine (v2)
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Identifies gaps and recommends fixes

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Running remediation analysis..." -ForegroundColor Cyan

$docsPath = Join-Path $modulePath "docs"

if (-not (Test-Path $docsPath)) {
    Write-Host "ERROR: docs folder not found at: $docsPath" -ForegroundColor Red
    exit 1
}

# Define expected minimums
$expectedPolicies  = 30
$expectedTemplates = 15

$policyCount   = (Get-ChildItem (Join-Path $docsPath "policies") -File -ErrorAction SilentlyContinue).Count
$templateCount = (Get-ChildItem (Join-Path $docsPath "templates") -File -ErrorAction SilentlyContinue).Count

Write-Host "`nCurrent State:" -ForegroundColor Cyan
Write-Host "Policies: $policyCount"
Write-Host "Templates: $templateCount"

# -----------------------------------------
# Policy Gap Detection
# -----------------------------------------
if ($policyCount -lt $expectedPolicies) {
    Write-Host "`nGAP: Missing policies ($policyCount / $expectedPolicies)" -ForegroundColor Yellow
    Write-Host "Recommendation:"
    Write-Host "- Add Vendor Risk Assessment Policy"
    Write-Host "- Add AI Governance Policy"
    Write-Host "- Add Data Classification Policy"
}

# -----------------------------------------
# Template Gap Detection
# -----------------------------------------
if ($templateCount -lt $expectedTemplates) {
    Write-Host "`nGAP: Missing templates ($templateCount / $expectedTemplates)" -ForegroundColor Yellow
    Write-Host "Recommendation:"
    Write-Host "- Incident Report Template"
    Write-Host "- Risk Register Template"
    Write-Host "- Audit Log Template"
}

# -----------------------------------------
# Evidence Check
# -----------------------------------------
$evidencePath = Join-Path $docsPath "evidence"
$restricted = Test-Path (Join-Path $evidencePath "restricted")
$business   = Test-Path (Join-Path $evidencePath "business")

if (-not $restricted -or -not $business) {
    Write-Host "`nGAP: Evidence structure incomplete" -ForegroundColor Red
}

Write-Host "`nRemediation analysis complete." -ForegroundColor Green
