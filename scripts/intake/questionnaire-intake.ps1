# =========================================
# TNDS Client Intake - JSON-driven
# =========================================
# Reads questionnaire.json and prompts for each field.
# Shows the example value next to every prompt so the user
# knows exactly what to type. Writes client-variable-map.json
# keyed by the PowerShell bracket tokens the injection engine uses.
#
# Usage:
#   .\questionnaire-intake.ps1 -modulePath "C:\...\compliance-gov-command"
#   .\questionnaire-intake.ps1 -modulePath "..." -questionnaire "..\..\questionnaire.json"

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath,
    [string]$questionnaire
)

# Resolve questionnaire path (default: repo root)
if (-not $questionnaire) {
    $scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
    $questionnaire = Join-Path (Split-Path (Split-Path $scriptRoot -Parent) -Parent) "questionnaire.json"
}

if (-not (Test-Path $questionnaire)) {
    Write-Host "ERROR: questionnaire.json not found at: $questionnaire" -ForegroundColor Red
    exit 1
}

$spec = Get-Content $questionnaire -Raw | ConvertFrom-Json

Write-Host "`nTNDS Client Intake" -ForegroundColor Cyan
Write-Host "Press Enter to skip optional fields. Type the example format shown in grey." -ForegroundColor Gray
Write-Host "Required fields are marked with *.`n" -ForegroundColor Gray

$answers = [ordered]@{}

foreach ($section in $spec.sections) {
    Write-Host "--- $($section.title) ---" -ForegroundColor Yellow

    foreach ($field in $section.fields) {
        # Skip fields that have no PS token (TS-only)
        if (-not $field.ps_token) { continue }

        $marker = if ($field.required) { "*" } else { " " }
        $example = if ($field.example) { "  e.g. $($field.example)" } else { "" }
        $default = if ($field.default) { " [$($field.default)]" } else { "" }

        Write-Host ("{0} {1}{2}{3}" -f $marker, $field.label, $default, $example) -ForegroundColor Gray
        $value = Read-Host "  >"

        if ([string]::IsNullOrWhiteSpace($value)) {
            if ($field.default) { $value = $field.default }
            elseif ($field.required) {
                Write-Host "  (required) using placeholder TBD" -ForegroundColor DarkYellow
                $value = "TBD"
            }
            else { continue }
        }

        $answers[$field.ps_token] = $value
    }
    Write-Host ""
}

# Auto-generated document metadata
$today = Get-Date -Format "yyyy-MM-dd"
if (-not $answers.Contains("DOCUMENT_DATE")) { $answers["DOCUMENT_DATE"] = $today }
if (-not $answers.Contains("REVIEW_DATE"))   { $answers["REVIEW_DATE"]   = $today }
if (-not $answers.Contains("REVIEW_PERIOD")) { $answers["REVIEW_PERIOD"] = "Annual" }
if (-not $answers.Contains("ORGANIZATION_NAME") -and $answers.Contains("COMPANY_LEGAL_NAME")) {
    $answers["ORGANIZATION_NAME"] = $answers["COMPANY_LEGAL_NAME"]
}
if (-not $answers.Contains("REVIEWER_NAME") -and $answers.Contains("OWNER_NAME")) {
    $answers["REVIEWER_NAME"] = $answers["OWNER_NAME"]
}

$outputPath = Join-Path $modulePath "client-variable-map.json"
$answers | ConvertTo-Json -Depth 3 | Out-File $outputPath -Encoding UTF8

Write-Host "client-variable-map.json written: $outputPath" -ForegroundColor Green
Write-Host "Variables mapped: $($answers.Count)" -ForegroundColor Cyan
