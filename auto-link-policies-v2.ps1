# =========================================
# TNDS Policy Auto-Link Engine (v2 - Precise)
# =========================================

Write-Host "Running v2 precise auto-linking..." -ForegroundColor Cyan

$policyPath = ".\compliance-gov-command\docs\policies"
$files = Get-ChildItem $policyPath -Filter "*.txt" -File

foreach ($file in $files) {

    $content = Get-Content $file.FullName -Raw
    $updated = $content

    # -----------------------------------------
    # IDENTITY / ACCESS
    # -----------------------------------------
    if ($file.Name -match "ACCESS|PASSWORD|REMOTE|AUTH|BYOD|MOBILE") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-IDENTITY-ACCESS-MANAGEMENT"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-ACCESS-REVIEW"
        $updated = $updated -replace "audit_logs", "access_logs"
    }

    # -----------------------------------------
    # INCIDENT RESPONSE
    # -----------------------------------------
    if ($file.Name -match "INCIDENT|BREACH") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-INCIDENT-RESPONSE"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-INCIDENT-REPORT"
        $updated = $updated -replace "audit_logs", "incident_reports"
    }

    # -----------------------------------------
    # BACKUP / DR
    # -----------------------------------------
    if ($file.Name -match "BACKUP|DISASTER|CONTINUITY") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-BACKUP-RECOVERY"
        $updated = $updated -replace "audit_logs", "backup_logs"
    }

    # -----------------------------------------
    # VENDOR / THIRD PARTY
    # -----------------------------------------
    if ($file.Name -match "VENDOR") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-VENDOR-MANAGEMENT"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-VENDOR-ASSESSMENT"
        $updated = $updated -replace "audit_logs", "vendor_assessments"
    }

    # -----------------------------------------
    # CHANGE / PATCH / VULNERABILITY
    # -----------------------------------------
    if ($file.Name -match "CHANGE") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-CHANGE-MANAGEMENT"
    }

    if ($file.Name -match "PATCH") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-PATCH-MANAGEMENT"
    }

    if ($file.Name -match "VULNERABILITY") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-VULNERABILITY-MANAGEMENT"
    }

    # -----------------------------------------
    # LOGGING / AUDIT
    # -----------------------------------------
    if ($file.Name -match "AUDIT|LOG") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-AUDIT-LOGGING"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-AUDIT-LOG"
        $updated = $updated -replace "audit_logs", "audit_logs"
    }

    # -----------------------------------------
    # TRAINING
    # -----------------------------------------
    if ($file.Name -match "TRAINING") {
        $updated = $updated -replace "audit_logs", "training_records"
    }

    # Save only if changed
    if ($updated -ne $content) {
        Set-Content -Path $file.FullName -Value $updated -Encoding UTF8
        Write-Host "UPDATED: $($file.Name)" -ForegroundColor Yellow
    }
    else {
        Write-Host "NO CHANGE: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "`nV2 auto-linking complete." -ForegroundColor Cyan