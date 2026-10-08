# =========================================
# TNDS Policy Auto-Link Engine (v2.1 Cleanup)
# =========================================

Write-Host "Running v2.1 cleanup + precision mapping..." -ForegroundColor Cyan

$policyPath = ".\compliance-gov-command\docs\policies"
$files = Get-ChildItem $policyPath -Filter "*.txt" -File

foreach ($file in $files) {

    $content = Get-Content $file.FullName -Raw
    $updated = $content

    # -----------------------------------------
    # DATA / PRIVACY DOMAIN
    # -----------------------------------------
    if ($file.Name -match "DATA|PRIVACY|CLASSIFICATION|LIFECYCLE|ANONYMIZATION") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-DATA-GOVERNANCE"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-DATA-REGISTER"
        $updated = $updated -replace "audit_logs", "data_processing_logs"
    }

    # -----------------------------------------
    # ASSET MANAGEMENT
    # -----------------------------------------
    if ($file.Name -match "ASSET") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-ASSET-MANAGEMENT"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-ASSET-INVENTORY"
    }

    # -----------------------------------------
    # ENCRYPTION / KEY MANAGEMENT
    # -----------------------------------------
    if ($file.Name -match "ENCRYPTION") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-CRYPTOGRAPHY-MANAGEMENT"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-KEY-INVENTORY"
        $updated = $updated -replace "audit_logs", "encryption_logs"
    }

    # -----------------------------------------
    # RECORDS MANAGEMENT
    # -----------------------------------------
    if ($file.Name -match "RECORDS") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-RECORDS-MANAGEMENT"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-RETENTION-SCHEDULE"
    }

    # -----------------------------------------
    # AI GOVERNANCE
    # -----------------------------------------
    if ($file.Name -match "AI") {
        $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-AI-GOVERNANCE"
        $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-AI-RISK-ASSESSMENT"
    }

    # -----------------------------------------
    # FALLBACK CLEANUP (if anything still remains)
    # -----------------------------------------
    $updated = $updated -replace "PROC-GENERAL-CONTROL", "PROC-COMPLIANCE-MANAGEMENT"
    $updated = $updated -replace "TEMPLATE-GENERAL", "TEMPLATE-COMPLIANCE-CHECKLIST"

    if ($updated -ne $content) {
        Set-Content -Path $file.FullName -Value $updated -Encoding UTF8
        Write-Host "UPDATED: $($file.Name)" -ForegroundColor Yellow
    }
    else {
        Write-Host "NO CHANGE: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "`nCleanup + mapping complete." -ForegroundColor Cyan