# =========================================
# TNDS Client Initialization Script
# =========================================
# ONE COMMAND orchestrator:
#   deploy -> intake -> inject -> enforce -> validate -> report
# Only interactive step: intake (client data entry)
# Everything else is fully automated via $modulePath

Write-Host "TNDS Compliance Command - Client Initialization" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# -----------------------------------------
# Step 1: Get Client Name (only user input besides intake)
# -----------------------------------------
$clientName = Read-Host "Enter client name (no spaces, use dashes)"

if ([string]::IsNullOrWhiteSpace($clientName)) {
    Write-Host "Client name is required. Exiting." -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 2: Define Paths
# -----------------------------------------
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$templatePath = Join-Path $root "client-compliance-command\compliance-gov-command"
$clientDeployDir = Join-Path $root "deployments\$clientName"
$scriptsRoot = Join-Path $root "scripts"

# After copy, the module lives directly inside the deployment folder
# Template copies as: deployments\<client>\compliance-gov-command\
$modulePath = Join-Path $clientDeployDir "compliance-gov-command"

# -----------------------------------------
# Step 3: Validate Template Exists
# -----------------------------------------
if (-not (Test-Path $templatePath)) {
    Write-Host "ERROR: Template not found at: $templatePath" -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 3b: Refuse a template that carries evidence (2026-10-08)
# -----------------------------------------
# The template's docs\evidence folders once held the owner's identity
# documents (DD214, VA letters, a licence photo, the EIN letter, the operating
# agreement), and Step 5 copies the whole template into every client
# deployment. Evidence belongs to a client deployment only, never to the
# template, so a template with any evidence file is refused.
$templateEvidence = Join-Path $templatePath "docs\evidence"
$leaked = @()
if (Test-Path $templateEvidence) {
    $leaked = @(Get-ChildItem $templateEvidence -Recurse -File -Force | Where-Object { $_.Name -ne '.gitkeep' })
}
if ($leaked.Count -gt 0) {
    Write-Host "REFUSED: the template carries $($leaked.Count) evidence file(s) under docs\evidence." -ForegroundColor Red
    Write-Host "Move them out of the template before deploying a client." -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 4: Check for Existing Client
# -----------------------------------------
if (Test-Path $clientDeployDir) {
    Write-Host "Client folder already exists: $clientDeployDir" -ForegroundColor Yellow
    exit 1
}

# -----------------------------------------
# Step 5: Deploy - Copy Template to Client
# -----------------------------------------
Write-Host "`n[1/7] DEPLOYING compliance system..." -ForegroundColor Yellow

New-Item -ItemType Directory -Path $clientDeployDir | Out-Null
Copy-Item $templatePath $clientDeployDir -Recurse

Write-Host "Compliance system deployed to: $modulePath" -ForegroundColor Green

# -----------------------------------------
# Step 6: Initialize Evidence Structure
# -----------------------------------------
$evidencePath = Join-Path $modulePath "docs\evidence"
New-Item -ItemType Directory -Path (Join-Path $evidencePath "restricted") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $evidencePath "business") -Force | Out-Null

Write-Host "Evidence structure initialized." -ForegroundColor Green

# -----------------------------------------
# Step 7: Create Client Config
# -----------------------------------------
$configPath = Join-Path $clientDeployDir "client-config.txt"

@"
Client Name: $clientName
Initialized: $(Get-Date)
System: TNDS Compliance Command
Module Path: $modulePath
Status: Active
"@ | Out-File $configPath

Write-Host "Client config created." -ForegroundColor Green

# -----------------------------------------
# Step 8: INTAKE - Build Variable Map (ONLY interactive step)
# -----------------------------------------
Write-Host "`n[2/7] INTAKE - collecting client data..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "intake\client-intake.ps1") -modulePath $modulePath

if ($LASTEXITCODE -ne 0) {
    Write-Host "Intake failed. Exiting." -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 9: INJECT - Replace Template Variables
# -----------------------------------------
Write-Host "`n[3/7] INJECTING client data into templates..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "injection\populate-client-data.ps1") -modulePath $modulePath

if ($LASTEXITCODE -ne 0) {
    Write-Host "Injection failed. Exiting." -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 10: ENFORCE - Fail if Placeholders Remain
# -----------------------------------------
Write-Host "`n[4/7] ENFORCING placeholder check..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "enforcement\enforce-no-placeholders.ps1") -modulePath $modulePath

if ($LASTEXITCODE -ne 0) {
    Write-Host "Onboarding FAILED due to unresolved variables." -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Step 11: VALIDATE - Structure + Traceability + Domain
# -----------------------------------------
Write-Host "`n[5/7] VALIDATING compliance module..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "validation\validate-compliance-module.ps1") -modulePath $modulePath
& (Join-Path $scriptsRoot "validation\traceability-validator.ps1") -modulePath $modulePath
& (Join-Path $scriptsRoot "validation\policy-domain-validator.ps1") -modulePath $modulePath

# -----------------------------------------
# Step 12: REMEDIATION - Gap Analysis
# -----------------------------------------
Write-Host "`n[6/7] REMEDIATION analysis..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "reporting\remediation-engine.ps1") -modulePath $modulePath

# -----------------------------------------
# Step 13: REPORT - Generate Compliance Report
# -----------------------------------------
Write-Host "`n[7/7] GENERATING compliance report..." -ForegroundColor Yellow

& (Join-Path $scriptsRoot "reporting\generate-compliance-report.ps1") -modulePath $modulePath

# -----------------------------------------
# DONE
# -----------------------------------------
Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "Client system fully initialized, enforced, and validated." -ForegroundColor Green
Write-Host "Deployment: $modulePath" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
