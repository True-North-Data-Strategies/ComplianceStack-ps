# =========================================
# TNDS Policy Auto-Link Engine (v1)
# =========================================

Write-Host "Running auto-linking..." -ForegroundColor Cyan

$policyPath = ".\compliance-gov-command\docs\policies"

$files = Get-ChildItem $policyPath -Filter "*.txt" -File

foreach ($file in $files) {

    $content = Get-Content $file.FullName -Raw

    # Skip already linked policies
    if ($content -notmatch "TBD") {
        Write-Host "SKIP (already linked): $($file.Name)" -ForegroundColor Green
        continue
    }

    $updated = $content

    # -----------------------------------------
    # RULE SET (Baseline mappings)
    # -----------------------------------------

    if ($file.Name -match "ACCESS_CONTROL") {
        $updated = $updated -replace "Related-Procedures:\s+- TBD", "Related-Procedures:`n  - PROC-ACCESS-CONTROL"
    }

    if ($file.Name -match "INCIDENT") {
        $updated = $updated -replace "Related-Procedures:\s+- TBD", "Related-Procedures:`n  - PROC-INCIDENT-RESPONSE"
        $updated = $updated -replace "Related-Templates:\s+- TBD", "Related-Templates:`n  - TEMPLATE-INCIDENT-REPORT"
    }

    if ($file.Name -match "BACKUP|DISASTER") {
        $updated = $updated -replace "Related-Procedures:\s+- TBD", "Related-Procedures:`n  - PROC-BACKUP-RECOVERY"
    }

    if ($file.Name -match "PASSWORD|ACCESS|AUTH") {
        $updated = $updated -replace "Evidence-Required:\s+- TBD", "Evidence-Required:`n  - access_logs"
    }

    # Default fallback
    $updated = $updated -replace "Related-Procedures:\s+- TBD", "Related-Procedures:`n  - PROC-GENERAL-CONTROL"
    $updated = $updated -replace "Related-Templates:\s+- TBD", "Related-Templates:`n  - TEMPLATE-GENERAL"
    $updated = $updated -replace "Evidence-Required:\s+- TBD", "Evidence-Required:`n  - audit_logs"

    Set-Content -Path $file.FullName -Value $updated -Encoding UTF8

    Write-Host "UPDATED: $($file.Name)" -ForegroundColor Yellow
}

Write-Host "`nAuto-linking complete." -ForegroundColor Cyan