# TNDS Module Normalizer

Write-Host "Normalizing module structure..."

# Create folders
mkdir app -ErrorAction SilentlyContinue
mkdir config -ErrorAction SilentlyContinue
mkdir docs -ErrorAction SilentlyContinue
mkdir scripts -ErrorAction SilentlyContinue

# Rename src → app
if (Test-Path src) { 
    Write-Host "Renaming src to app"
    mv src app 
}

# Move config files
mv config.json config/ -ErrorAction SilentlyContinue
mv .clasp* config/ -ErrorAction SilentlyContinue
mv *.env config/ -ErrorAction SilentlyContinue

# Move scripts
mv *.py scripts/ -ErrorAction SilentlyContinue
mv *.ps1 scripts/ -ErrorAction SilentlyContinue
mv *.js scripts/ -ErrorAction SilentlyContinue

# Move UI files
mv *.html app/ -ErrorAction SilentlyContinue

# Move docs
mv *.md docs/ -ErrorAction SilentlyContinue
mv *.docx docs/ -ErrorAction SilentlyContinue

# Cleanup
rm -r node_modules -ErrorAction SilentlyContinue
rm -r dist -ErrorAction SilentlyContinue

Write-Host "Done."