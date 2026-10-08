# =========================================
# TNDS Placeholder Enforcement Engine
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Scans docs for unresolved [ALL_CAPS] client variables
# Ignores form-field placeholders (table headers, templates)
# Returns exit 1 if real client variables remain unresolved

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Running placeholder enforcement..." -ForegroundColor Cyan

$docsPath = Join-Path $modulePath "docs"

if (-not (Test-Path $docsPath)) {
    Write-Host "ERROR: docs folder not found at: $docsPath" -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Form-field allowlist: these are table headers,
# template field labels, and review placeholders
# that are NOT client-specific variables.
# -----------------------------------------
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

$pattern = "\[([A-Z][A-Z0-9_]{2,})\]"
$files = Get-ChildItem $docsPath -Recurse -Include "*.txt","*.md" -File

$violations = @()
$skippedCount = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
    }
    catch {
        continue
    }

    if ([string]::IsNullOrWhiteSpace($content)) {
        continue
    }

    $matches = [regex]::Matches($content, $pattern)

    if ($matches.Count -gt 0) {
        $realVars = @()

        foreach ($match in $matches) {
            $varName = $match.Groups[1].Value

            if ($allowlist -contains $varName) {
                $skippedCount++
                continue
            }

            $realVars += $varName
        }

        $uniqueVars = $realVars | Select-Object -Unique

        if ($uniqueVars.Count -gt 0) {
            $violations += @{
                File = $file.FullName
                Variables = ($uniqueVars -join ", ")
            }
        }
    }
}

# -----------------------------------------
# Results
# -----------------------------------------
if ($skippedCount -gt 0) {
    Write-Host "Allowlisted form-field placeholders skipped: $skippedCount" -ForegroundColor DarkGray
}

if ($violations.Count -gt 0) {
    Write-Host "`nPLACEHOLDER VIOLATIONS FOUND:" -ForegroundColor Red

    foreach ($v in $violations) {
        Write-Host "  $($v.File)" -ForegroundColor Yellow
        Write-Host "    Variables: $($v.Variables)" -ForegroundColor DarkYellow
    }

    Write-Host "`nDeployment FAILED. Unresolved client variables exist." -ForegroundColor Red
    exit 1
}
else {
    Write-Host "No unresolved client variables. System is clean." -ForegroundColor Green
    exit 0
}
