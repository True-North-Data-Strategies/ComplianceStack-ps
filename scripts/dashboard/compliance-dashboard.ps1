# =========================================
# TNDS Compliance Dashboard (CLI)
# =========================================
# Iterates all client deployments and runs reports
# Uses parameterized calls to all scripts

param (
    [string]$deploymentsRoot
)

# Resolve root from script location if not passed
if (-not $deploymentsRoot) {
    $scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
    $systemRoot = Split-Path -Parent (Split-Path -Parent $scriptRoot)
    $deploymentsRoot = Join-Path $systemRoot "deployments"
}

Write-Host "TNDS Compliance Dashboard" -ForegroundColor Cyan
Write-Host "Scanning: $deploymentsRoot" -ForegroundColor Gray

if (-not (Test-Path $deploymentsRoot)) {
    Write-Host "ERROR: Deployments folder not found: $deploymentsRoot" -ForegroundColor Red
    exit 1
}

$clients = Get-ChildItem $deploymentsRoot -Directory

if ($clients.Count -eq 0) {
    Write-Host "No client deployments found." -ForegroundColor Yellow
    exit 0
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$reportScript = Join-Path (Split-Path -Parent $scriptRoot) "reporting\generate-compliance-report.ps1"

foreach ($client in $clients) {

    Write-Host "`n=============================" -ForegroundColor Yellow
    Write-Host "Client: $($client.Name)" -ForegroundColor Cyan

    # Find the compliance-gov-command folder inside the client deployment
    $modulePath = Join-Path $client.FullName "compliance-gov-command"

    if (-not (Test-Path $modulePath)) {
        Write-Host "SKIP: No compliance-gov-command folder found" -ForegroundColor DarkYellow
        continue
    }

    & $reportScript -modulePath $modulePath
}

Write-Host "`n=============================" -ForegroundColor Yellow
Write-Host "Dashboard complete. Clients scanned: $($clients.Count)" -ForegroundColor Green
