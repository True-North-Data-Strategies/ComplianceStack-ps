# =========================================
# TNDS Variable Scanner (v4 - Parameterized)
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Scans docs for template variables and validates against config

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Scanning for template variables..." -ForegroundColor Cyan

$scanPath = Join-Path $modulePath "docs"
$configPath = Join-Path $modulePath "client-variable-map.json"

if (-not (Test-Path $scanPath)) {
    Write-Host "ERROR: docs folder not found at: $scanPath" -ForegroundColor Red
    exit 1
}

# Form-field allowlist (table headers, not client variables)
$allowlist = @(
    "STATUS", "EVIDENCE", "FINDING", "DATE", "ACTION",
    "OWNER", "NUMBER", "SKILLS", "SKILL", "PERCENT",
    "IMPACT", "IMPACT_LEVEL", "SCORE", "METHOD", "DOCUMENT",
    "DOCUMENT_NAME", "DOCUMENTS", "RISK", "GAP", "NAME",
    "FACTOR", "TYPE", "TARGET", "LEVEL", "ELEMENT",
    "CATEGORY", "SOURCE", "PURPOSE", "FRAMEWORK", "CURRENT",
    "CURRENT_LANGUAGE", "RECOMMENDED", "RECOMMENDATION",
    "OBSERVATION", "ASSESSMENT", "ENHANCEMENT", "REDACTED"
)

# STRICT pattern: Only matches [ALL_CAPS_VARIABLES]
$pattern = "\[([A-Z][A-Z0-9_]{2,})\]"

$files = Get-ChildItem $scanPath -Recurse -Include "*.txt","*.md" -File

$foundVariables = @{}
$formFieldCount = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
    }
    catch {
        Write-Host "SKIP (unreadable): $($file.FullName)" -ForegroundColor DarkYellow
        continue
    }

    if ([string]::IsNullOrWhiteSpace($content)) {
        continue
    }

    $matches = [regex]::Matches($content, $pattern)

    foreach ($match in $matches) {
        $varName = $match.Groups[1].Value

        if ($allowlist -contains $varName) {
            $formFieldCount++
            continue
        }

        if (-not $foundVariables.ContainsKey($varName)) {
            $foundVariables[$varName] = @()
        }

        $foundVariables[$varName] += $file.Name
    }
}

if ($formFieldCount -gt 0) {
    Write-Host "Form-field placeholders skipped (allowlisted): $formFieldCount" -ForegroundColor DarkGray
}

Write-Host "`n=== CLIENT VARIABLES FOUND ===" -ForegroundColor Yellow

if ($foundVariables.Count -eq 0) {
    Write-Host "No variables detected." -ForegroundColor DarkYellow
}
else {
    foreach ($key in $foundVariables.Keys | Sort-Object) {
        $fileCount = ($foundVariables[$key] | Select-Object -Unique).Count
        Write-Host "$key  (used in $fileCount files)" -ForegroundColor Green
    }
}

# -----------------------------------------
# Compare against config
# -----------------------------------------
if (Test-Path $configPath) {

    Write-Host "`n=== VALIDATING AGAINST VARIABLE MAP ===" -ForegroundColor Cyan

    $configVars = (Get-Content $configPath | ConvertFrom-Json).PSObject.Properties.Name
    $missingVariables = @()

    foreach ($key in $foundVariables.Keys) {
        if ($configVars -notcontains $key) {
            Write-Host "MISSING IN MAP: $key" -ForegroundColor Red
            $missingVariables += $key
        }
    }

    foreach ($key in $configVars) {
        if ($foundVariables.Keys -notcontains $key) {
            Write-Host "UNUSED IN DOCS: $key" -ForegroundColor DarkYellow
        }
    }

    Write-Host "`nMissing Variable Count: $($missingVariables.Count)" -ForegroundColor Yellow
}
else {
    Write-Host "`nNo client-variable-map.json found. Skipping validation." -ForegroundColor DarkYellow
}

Write-Host "`nScan complete." -ForegroundColor Cyan
