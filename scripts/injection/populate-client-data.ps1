# =========================================
# TNDS Template Population Engine
# =========================================
# Accepts $modulePath = the compliance-gov-command folder itself
# Reads client-variable-map.json from $modulePath
# Replaces ALL template variables in docs/*.txt

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "Populating client data..." -ForegroundColor Cyan

if (-not (Test-Path $modulePath)) {
    Write-Host "ERROR: Module path not found: $modulePath" -ForegroundColor Red
    exit 1
}

# Load variable map from the module root
$mapPath = Join-Path $modulePath "client-variable-map.json"

if (-not (Test-Path $mapPath)) {
    Write-Host "ERROR: client-variable-map.json not found at: $mapPath" -ForegroundColor Red
    exit 1
}

$variableMap = Get-Content $mapPath -Raw | ConvertFrom-Json

# Target: docs folder INSIDE the module path (no double-nesting)
$docsPath = Join-Path $modulePath "docs"

if (-not (Test-Path $docsPath)) {
    Write-Host "ERROR: docs folder not found at: $docsPath" -ForegroundColor Red
    exit 1
}

$files = Get-ChildItem $docsPath -Recurse -Include "*.txt","*.md" -File

$replacedCount = 0

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

    $original = $content

    # Replace every variable from the map
    foreach ($prop in $variableMap.PSObject.Properties) {
        $placeholder = "\[$($prop.Name)\]"
        $content = $content -replace [regex]::Escape("[$($prop.Name)]"), $prop.Value
    }

    if ($content -ne $original) {
        Set-Content $file.FullName $content -NoNewline
        Write-Host "UPDATED: $($file.Name)" -ForegroundColor Green
        $replacedCount++
    }
}

Write-Host "`nClient data population complete. Files updated: $replacedCount" -ForegroundColor Cyan
