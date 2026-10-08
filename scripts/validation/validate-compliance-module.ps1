# =========================================
# TNDS Compliance Module Validator (v2 - Path Safe)
# =========================================

param (
    [string]$modulePath
)

# -----------------------------------------
# Resolve module path
# -----------------------------------------
if (-not $modulePath) {
    $modulePath = Get-Location
}

$docsPath = Join-Path $modulePath "docs"

if (-not (Test-Path $docsPath)) {
    Write-Host "ERROR: docs folder not found at $docsPath" -ForegroundColor Red
    exit 1
}

Write-Host "Validating compliance module at:" -ForegroundColor Cyan
Write-Host $modulePath -ForegroundColor Gray

# -----------------------------------------
# Required structure
# -----------------------------------------
$requiredFolders = @(
    "policies",
    "procedures",
    "templates",
    "frameworks",
    "research",
    "artifacts",
    "evidence"
)

# -----------------------------------------
# Check folder structure
# -----------------------------------------
$structureHits = 0

foreach ($folder in $requiredFolders) {
    $path = Join-Path $docsPath $folder

    if (Test-Path $path) {
        Write-Host "OK: $folder exists" -ForegroundColor Green
        $structureHits++
    } else {
        Write-Host "MISSING: $folder" -ForegroundColor Red
    }
}

# -----------------------------------------
# Evidence structure
# -----------------------------------------
$evidencePath = Join-Path $docsPath "evidence"
$restricted = Join-Path $evidencePath "restricted"
$business   = Join-Path $evidencePath "business"

$evidenceScore = 0

if (Test-Path $restricted) {
    Write-Host "OK: evidence/restricted exists" -ForegroundColor Green
} else {
    Write-Host "MISSING: evidence/restricted" -ForegroundColor Red
}

if (Test-Path $business) {
    Write-Host "OK: evidence/business exists" -ForegroundColor Green
} else {
    Write-Host "MISSING: evidence/business" -ForegroundColor Red
}

if ((Test-Path $restricted) -and (Test-Path $business)) {
    $evidenceScore = 15
}

# -----------------------------------------
# Counts
# -----------------------------------------
$policyPath = Join-Path $docsPath "policies"
$templatePath = Join-Path $docsPath "templates"
$procedurePath = Join-Path $docsPath "procedures"
$artifactPath = Join-Path $docsPath "artifacts"

$policyCount = (Get-ChildItem $policyPath -File -ErrorAction SilentlyContinue).Count
$templateCount = (Get-ChildItem $templatePath -File -ErrorAction SilentlyContinue).Count
$procedureCount = (Get-ChildItem $procedurePath -File -ErrorAction SilentlyContinue).Count
$artifactCount = (Get-ChildItem $artifactPath -File -ErrorAction SilentlyContinue).Count

Write-Host "`nSummary:" -ForegroundColor Cyan
Write-Host "Policies: $policyCount"
Write-Host "Templates: $templateCount"
Write-Host "Procedures: $procedureCount"
Write-Host "Artifacts: $artifactCount"

# -----------------------------------------
# Risk Check: loose files in evidence root
# -----------------------------------------
$looseEvidence = Get-ChildItem $evidencePath -File -ErrorAction SilentlyContinue

if ($looseEvidence.Count -gt 0) {
    Write-Host "`nWARNING: Loose files in evidence root!" -ForegroundColor Yellow
    $looseEvidence | ForEach-Object {
        Write-Host " - $($_.Name)" -ForegroundColor Yellow
    }
} else {
    Write-Host "`nOK: No loose files in evidence root" -ForegroundColor Green
}

# -----------------------------------------
# Compliance Scoring
# -----------------------------------------
$score = 0
$maxScore = 100

# Structure (30 pts)
$score += ($structureHits * 4)

# Evidence (15 pts)
$score += $evidenceScore

# Policies (25 pts)
if ($policyCount -ge 30) {
    $score += 25
} elseif ($policyCount -ge 20) {
    $score += 18
} elseif ($policyCount -ge 10) {
    $score += 10
}

# Templates (15 pts)
if ($templateCount -ge 15) {
    $score += 15
} elseif ($templateCount -ge 10) {
    $score += 10
} elseif ($templateCount -ge 5) {
    $score += 5
}

# Procedures (10 pts)
if ($procedureCount -ge 15) {
    $score += 10
} elseif ($procedureCount -ge 8) {
    $score += 5
}

# Artifacts (5 pts)
if ($artifactCount -ge 2) {
    $score += 5
}

# -----------------------------------------
# Final Output
# -----------------------------------------
Write-Host "`nValidation complete." -ForegroundColor Cyan

Write-Host "`nCompliance Score: $score / $maxScore" -ForegroundColor Cyan

if ($score -ge 95) {
    Write-Host "Status: ELITE" -ForegroundColor Green
} elseif ($score -ge 85) {
    Write-Host "Status: STRONG" -ForegroundColor Green
} elseif ($score -ge 70) {
    Write-Host "Status: MODERATE" -ForegroundColor Yellow
} else {
    Write-Host "Status: NEEDS WORK" -ForegroundColor Red
}
