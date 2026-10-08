$policyPath = ".\compliance-gov-command\docs\policies"

$files = Get-ChildItem $policyPath -Filter "*.txt" -File

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw

    # Skip files that already begin with metadata front matter
    if ($content -match '^\s*---\s*\r?\n') {
        Write-Host "SKIP (already has metadata): $($file.Name)" -ForegroundColor Yellow
        continue
    }

    # Extract numeric prefix from filename, e.g. 01_, 22_, etc.
    $match = [regex]::Match($file.BaseName, '^(\d{2})_')
    if ($match.Success) {
        $num = [int]$match.Groups[1].Value
        $policyId = "POL-{0:d3}" -f $num
    }
    else {
        $policyId = "POL-TBD"
    }

    # Create a readable policy name from filename
    $policyName = $file.BaseName -replace '^\d{2}_', ''
    $policyName = $policyName -replace '_', ' '

    $metadata = @"
---
Policy-ID: $policyId
Policy-Name: $policyName
Related-Procedures:
  - TBD
Related-Templates:
  - TBD
Evidence-Required:
  - TBD
Status: draft
---
"@

    $newContent = $metadata + "`r`n" + $content
    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8

    Write-Host "UPDATED: $($file.Name)" -ForegroundColor Green
}
