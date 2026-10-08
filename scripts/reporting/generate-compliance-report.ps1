# =========================================
# TNDS Compliance Report Generator
# =========================================
# Accepts $modulePath = the compliance-gov-command folder
# Calculates REAL compliance score and writes report

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Generating compliance report..." -ForegroundColor Cyan

$docsPath = Join-Path $modulePath "docs"

if (-not (Test-Path $docsPath)) {
    Write-Host "ERROR: docs folder not found at: $docsPath" -ForegroundColor Red
    exit 1
}

# -----------------------------------------
# Setup output
# -----------------------------------------
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$dataDir = Join-Path $modulePath "data"

if (!(Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

$outputFile = Join-Path $dataDir "compliance-report-$timestamp.txt"

# -----------------------------------------
# Counts
# -----------------------------------------
$policyPath    = Join-Path $docsPath "policies"
$templatePath  = Join-Path $docsPath "templates"
$procedurePath = Join-Path $docsPath "procedures"
$artifactPath  = Join-Path $docsPath "artifacts"
$evidencePath  = Join-Path $docsPath "evidence"

$policyCount    = (Get-ChildItem $policyPath -File -ErrorAction SilentlyContinue).Count
$templateCount  = (Get-ChildItem $templatePath -File -ErrorAction SilentlyContinue).Count
$procedureCount = (Get-ChildItem $procedurePath -File -ErrorAction SilentlyContinue).Count
$artifactCount  = (Get-ChildItem $artifactPath -File -ErrorAction SilentlyContinue).Count

# Evidence check
$restrictedExists = Test-Path (Join-Path $evidencePath "restricted")
$businessExists   = Test-Path (Join-Path $evidencePath "business")

# -----------------------------------------
# Required folder structure check
# -----------------------------------------
$requiredFolders = @("policies", "procedures", "templates", "frameworks", "research", "artifacts", "evidence")
$structureHits = 0

foreach ($folder in $requiredFolders) {
    if (Test-Path (Join-Path $docsPath $folder)) {
        $structureHits++
    }
}

# -----------------------------------------
# Compliance Scoring (same logic as validator)
# -----------------------------------------
$score = 0
$maxScore = 100

# Structure (30 pts) - ~4 pts per folder
$score += ($structureHits * 4)

# Evidence (15 pts)
if ($restrictedExists -and $businessExists) {
    $score += 15
}

# Policies (25 pts)
if ($policyCount -ge 30) { $score += 25 }
elseif ($policyCount -ge 20) { $score += 18 }
elseif ($policyCount -ge 10) { $score += 10 }

# Templates (15 pts)
if ($templateCount -ge 15) { $score += 15 }
elseif ($templateCount -ge 10) { $score += 10 }
elseif ($templateCount -ge 5) { $score += 5 }

# Procedures (10 pts)
if ($procedureCount -ge 15) { $score += 10 }
elseif ($procedureCount -ge 8) { $score += 5 }

# Artifacts (5 pts)
if ($artifactCount -ge 2) { $score += 5 }

# Status
if ($score -ge 95) { $status = "ELITE" }
elseif ($score -ge 85) { $status = "STRONG" }
elseif ($score -ge 70) { $status = "MODERATE" }
else { $status = "NEEDS WORK" }

# -----------------------------------------
# Write Report
# -----------------------------------------
$report = @"
TNDS COMPLIANCE REPORT
Generated: $timestamp
Module: $modulePath
----------------------------------------
Policies:   $policyCount
Procedures: $procedureCount
Templates:  $templateCount
Artifacts:  $artifactCount
Folders:    $structureHits / $($requiredFolders.Count)

Evidence Structure:
  Restricted: $restrictedExists
  Business:   $businessExists

Compliance Score: $score / $maxScore
Status: $status
----------------------------------------
"@

$report | Out-File $outputFile -Encoding UTF8

# Also print to console
Write-Host $report -ForegroundColor Cyan
Write-Host "Report saved: $outputFile" -ForegroundColor Green
