# =========================================
# TNDS Client Intake -> JSON Generator
# =========================================
# Collects ALL client-specific variables needed for template injection.
# Hardcodes cloud defaults where TNDS standard applies.
# Derives computed fields from user inputs where possible.

param (
    [Parameter(Mandatory=$true)]
    [string]$modulePath
)

Write-Host "`nTNDS Client Intake" -ForegroundColor Cyan
Write-Host "Answer each prompt. Type TBD if unknown.`n" -ForegroundColor Gray

# -----------------------------------------
# Core Company Info
# -----------------------------------------
$companyLegalName = Read-Host "Company Legal Name"
$companyName      = Read-Host "Company Short Name (e.g. TNDS)"
$companyAbbrev    = Read-Host "Company Abbreviation (e.g. TNDS)"
$ownerName        = Read-Host "Owner Full Name"
$contactEmail     = Read-Host "Contact Email"
$contactPhone     = Read-Host "Contact Phone"
$companyWebsite   = Read-Host "Company Website"

# -----------------------------------------
# Location
# -----------------------------------------
$companyCity         = Read-Host "City"
$governingState      = Read-Host "State (e.g. Colorado)"
$companyCityStateZip = Read-Host "Full City/State/ZIP (e.g. Colorado Springs, CO 80903)"

# -----------------------------------------
# Government / Registration
# -----------------------------------------
$companyUEI          = Read-Host "UEI Number (or TBD)"
$companyCageCode     = Read-Host "CAGE Code (or TBD)"
$companyEIN          = Read-Host "EIN (or TBD)"
$businessDesignation = Read-Host "Business Designation (e.g. Service-Disabled Veteran-Owned Small Business)"
$ownerVeteranStatus  = Read-Host "Owner Veteran Status (e.g. Service-Disabled Veteran)"
$samExpiration       = Read-Host "SAM.gov Expiration Date (or TBD)"
$stateRegId          = Read-Host "State Registration ID (or TBD)"
$governingJuris      = Read-Host "Governing Jurisdiction (e.g. State of Colorado)"

# -----------------------------------------
# Cloud Defaults (TNDS standard stack)
# -----------------------------------------
Write-Host "`nCloud defaults (press Enter to accept, or type override):" -ForegroundColor Gray

$cloudPlatformWS = Read-Host "Cloud Workspace Platform [Google Workspace]"
if ([string]::IsNullOrWhiteSpace($cloudPlatformWS)) { $cloudPlatformWS = "Google Workspace" }

$cloudProvider = Read-Host "Cloud Provider [Google]"
if ([string]::IsNullOrWhiteSpace($cloudProvider)) { $cloudProvider = "Google" }

$cloudProviderDomain = Read-Host "Cloud Provider Domain [google.com]"
if ([string]::IsNullOrWhiteSpace($cloudProviderDomain)) { $cloudProviderDomain = "google.com" }

$cloudPlatform = Read-Host "Cloud Platform [Google Cloud Platform]"
if ([string]::IsNullOrWhiteSpace($cloudPlatform)) { $cloudPlatform = "Google Cloud Platform" }

$cloudAIPlatform = Read-Host "Cloud AI Platform [Google AI / Vertex AI]"
if ([string]::IsNullOrWhiteSpace($cloudAIPlatform)) { $cloudAIPlatform = "Google AI / Vertex AI" }

$cloudIAM = Read-Host "Cloud IAM System [Google Cloud IAM]"
if ([string]::IsNullOrWhiteSpace($cloudIAM)) { $cloudIAM = "Google Cloud IAM" }

$cloudPartner = Read-Host "Cloud Partner [Google Cloud Partner]"
if ([string]::IsNullOrWhiteSpace($cloudPartner)) { $cloudPartner = "Google Cloud Partner" }

$cloudPartnerReseller = Read-Host "Cloud Partner/Reseller [Carahsoft]"
if ([string]::IsNullOrWhiteSpace($cloudPartnerReseller)) { $cloudPartnerReseller = "Carahsoft" }

# -----------------------------------------
# Document Metadata
# -----------------------------------------
$documentDate  = Get-Date -Format "yyyy-MM-dd"
$reviewDate    = $documentDate
$reviewPeriod  = "Annual"
$reviewerName  = $ownerName
$reviewerTitle = "Owner / Compliance Officer"
$orgName       = $companyLegalName

# -----------------------------------------
# Build Variable Map
# -----------------------------------------
$data = [ordered]@{
    # Core
    COMPANY_LEGAL_NAME       = $companyLegalName
    COMPANY_NAME             = $companyName
    COMPANY_ABBREVIATION     = $companyAbbrev
    ORGANIZATION_NAME        = $orgName
    OWNER_NAME               = $ownerName
    CONTACT_EMAIL            = $contactEmail
    CONTACT_PHONE            = $contactPhone
    COMPANY_WEBSITE          = $companyWebsite

    # Location
    COMPANY_CITY             = $companyCity
    GOVERNING_STATE          = $governingState
    COMPANY_CITY_STATE_ZIP   = $companyCityStateZip
    GOVERNING_JURISDICTION   = $governingJuris

    # Government
    COMPANY_UEI              = $companyUEI
    COMPANY_CAGE_CODE        = $companyCageCode
    COMPANY_EIN              = $companyEIN
    BUSINESS_DESIGNATION     = $businessDesignation
    OWNER_VETERAN_STATUS     = $ownerVeteranStatus
    SAM_EXPIRATION_DATE      = $samExpiration
    STATE_REGISTRATION_ID    = $stateRegId

    # Cloud
    CLOUD_PLATFORM_WORKSPACE = $cloudPlatformWS
    CLOUD_PROVIDER           = $cloudProvider
    CLOUD_PROVIDER_DOMAIN    = $cloudProviderDomain
    CLOUD_PLATFORM           = $cloudPlatform
    CLOUD_AI_PLATFORM        = $cloudAIPlatform
    CLOUD_IAM                = $cloudIAM
    CLOUD_PARTNER            = $cloudPartner
    CLOUD_PARTNER_RESELLER   = $cloudPartnerReseller

    # Document Metadata (auto-generated)
    DOCUMENT_DATE            = $documentDate
    REVIEW_DATE              = $reviewDate
    REVIEW_PERIOD            = $reviewPeriod
    REVIEWER_NAME            = $reviewerName
    REVIEWER_TITLE           = $reviewerTitle
}

# -----------------------------------------
# Write JSON
# -----------------------------------------
$outputPath = Join-Path $modulePath "client-variable-map.json"
$data | ConvertTo-Json -Depth 3 | Out-File $outputPath -Encoding UTF8

Write-Host "`nclient-variable-map.json created at: $outputPath" -ForegroundColor Green
Write-Host "Variables mapped: $($data.Count)" -ForegroundColor Cyan
