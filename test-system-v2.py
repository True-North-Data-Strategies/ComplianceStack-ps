#!/usr/bin/env python3
"""TNDS Compliance System - V2 Integration Test (with full variable map + allowlist)"""
import os, sys, json, re, shutil
from datetime import datetime

ROOT = os.path.dirname(os.path.abspath(__file__))
TEMPLATE = os.path.join(ROOT, "client-compliance-command", "compliance-gov-command")
TEST_CLIENT = "test-v2-" + datetime.now().strftime("%H%M%S")
CLIENT_DEPLOY = os.path.join(ROOT, "deployments", TEST_CLIENT)
MODULE_PATH = os.path.join(CLIENT_DEPLOY, "compliance-gov-command")

errors = 0
passes = 0

def test(name, cond, detail=""):
    global errors, passes
    if cond:
        print("  PASS: " + name)
        passes += 1
    else:
        print("  FAIL: " + name + " -- " + detail)
        errors += 1

# Form-field allowlist (matches enforce-no-placeholders.ps1)
ALLOWLIST = {
    "STATUS", "EVIDENCE", "FINDING", "DATE", "ACTION",
    "OWNER", "NUMBER", "SKILLS", "SKILL", "PERCENT",
    "IMPACT", "IMPACT_LEVEL", "SCORE", "METHOD", "DOCUMENT",
    "DOCUMENT_NAME", "DOCUMENTS", "RISK", "GAP", "NAME",
    "FACTOR", "TYPE", "TARGET", "LEVEL", "ELEMENT",
    "CATEGORY", "SOURCE", "PURPOSE", "FRAMEWORK", "CURRENT",
    "CURRENT_LANGUAGE", "RECOMMENDED", "RECOMMENDATION",
    "OBSERVATION", "ASSESSMENT", "ENHANCEMENT", "REDACTED",
}

print("=" * 60)
print("TNDS COMPLIANCE SYSTEM - V2 TEST (full map + allowlist)")
print("=" * 60)

# Deploy
print("\n[1] DEPLOY")
os.makedirs(CLIENT_DEPLOY, exist_ok=True)
shutil.copytree(TEMPLATE, MODULE_PATH)
docs_path = os.path.join(MODULE_PATH, "docs")
ev_path = os.path.join(docs_path, "evidence")
os.makedirs(os.path.join(ev_path, "restricted"), exist_ok=True)
os.makedirs(os.path.join(ev_path, "business"), exist_ok=True)
test("Deployed", os.path.isdir(MODULE_PATH))

# Full variable map (matches new intake)
print("\n[2] INTAKE (simulated with full map)")
today = datetime.now().strftime("%Y-%m-%d")
vmap = {
    "COMPANY_LEGAL_NAME": "True North Data Strategies LLC",
    "COMPANY_NAME": "True North Data Strategies",
    "COMPANY_ABBREVIATION": "TNDS",
    "ORGANIZATION_NAME": "True North Data Strategies LLC",
    "OWNER_NAME": "Jacob Johnston",
    "CONTACT_EMAIL": "jacob@truenorthstrategyops.com",
    "CONTACT_PHONE": "719-204-6365",
    "COMPANY_WEBSITE": "truenorthstrategyops.com",
    "COMPANY_CITY": "Colorado Springs",
    "GOVERNING_STATE": "Colorado",
    "COMPANY_CITY_STATE_ZIP": "Colorado Springs, CO 80903",
    "GOVERNING_JURISDICTION": "State of Colorado",
    "COMPANY_UEI": "TBD",
    "COMPANY_CAGE_CODE": "TBD",
    "COMPANY_EIN": "TBD",
    "BUSINESS_DESIGNATION": "Service-Disabled Veteran-Owned Small Business",
    "OWNER_VETERAN_STATUS": "Service-Disabled Veteran",
    "SAM_EXPIRATION_DATE": "TBD",
    "STATE_REGISTRATION_ID": "TBD",
    "CLOUD_PLATFORM_WORKSPACE": "Google Workspace",
    "CLOUD_PROVIDER": "Google",
    "CLOUD_PROVIDER_DOMAIN": "google.com",
    "CLOUD_PLATFORM": "Google Cloud Platform",
    "CLOUD_AI_PLATFORM": "Google AI / Vertex AI",
    "CLOUD_IAM": "Google Cloud IAM",
    "CLOUD_PARTNER": "Google Cloud Partner",
    "CLOUD_PARTNER_RESELLER": "Carahsoft",
    "DOCUMENT_DATE": today,
    "REVIEW_DATE": today,
    "REVIEW_PERIOD": "Annual",
    "REVIEWER_NAME": "Jacob Johnston",
    "REVIEWER_TITLE": "Owner / Compliance Officer",
}

map_path = os.path.join(MODULE_PATH, "client-variable-map.json")
with open(map_path, "w") as f:
    json.dump(vmap, f, indent=2)
test("Variable map: %d variables" % len(vmap), len(vmap) >= 30)

# Inject
print("\n[3] INJECTION")
pat = re.compile(r"\[([A-Z][A-Z0-9_]{2,})\]")

all_docs = []
for dp, _, fns in os.walk(docs_path):
    for fn in fns:
        if fn.endswith(".md") or fn.endswith(".txt"):
            all_docs.append(os.path.join(dp, fn))

total_before = 0
for fp in all_docs:
    total_before += len(pat.findall(open(fp, errors="ignore").read()))
print("  Total placeholders before: %d" % total_before)

updated = 0
for fp in all_docs:
    c = open(fp, errors="ignore").read()
    orig = c
    for vn, vv in vmap.items():
        c = c.replace("[" + vn + "]", vv)
    if c != orig:
        with open(fp, "w") as f:
            f.write(c)
        updated += 1
print("  Files updated: %d" % updated)
test("Injection ran", updated > 0)

# Enforcement (with allowlist)
print("\n[4] ENFORCEMENT (with allowlist)")
remaining_client_vars = {}
allowlisted_count = 0

for fp in all_docs:
    c = open(fp, errors="ignore").read()
    matches = pat.findall(c)
    if matches:
        real_vars = []
        for m in matches:
            if m in ALLOWLIST:
                allowlisted_count += 1
            else:
                real_vars.append(m)
        unique_real = list(set(real_vars))
        if unique_real:
            remaining_client_vars[os.path.basename(fp)] = unique_real

print("  Allowlisted form-fields skipped: %d" % allowlisted_count)

if remaining_client_vars:
    total_remaining = sum(len(v) for v in remaining_client_vars.values())
    unique_vars = set()
    for vl in remaining_client_vars.values():
        unique_vars.update(vl)
    print("  REMAINING client vars: %d instances, %d unique" % (total_remaining, len(unique_vars)))
    for vn in sorted(unique_vars):
        print("    - " + vn)
    test("Enforcement PASS (zero remaining)", False,
         "%d unique client vars still unresolved" % len(unique_vars))
else:
    test("Enforcement PASS (zero remaining client vars)", True)

# Scoring
print("\n[5] VALIDATION + SCORING")
req = ["policies","procedures","templates","frameworks","research","artifacts","evidence"]
hits = sum(1 for r in req if os.path.isdir(os.path.join(docs_path, r)))

def cf(sub):
    p = os.path.join(docs_path, sub)
    return len([x for x in os.listdir(p) if os.path.isfile(os.path.join(p, x))]) if os.path.isdir(p) else 0

pc, tc, prc, ac = cf("policies"), cf("templates"), cf("procedures"), cf("artifacts")
print("  Policies:%d Templates:%d Procedures:%d Artifacts:%d" % (pc, tc, prc, ac))

score = hits * 4
if os.path.isdir(os.path.join(ev_path,"restricted")) and os.path.isdir(os.path.join(ev_path,"business")):
    score += 15
if pc >= 30: score += 25
elif pc >= 20: score += 18
elif pc >= 10: score += 10
if tc >= 15: score += 15
elif tc >= 10: score += 10
elif tc >= 5: score += 5
if prc >= 15: score += 10
elif prc >= 8: score += 5
if ac >= 2: score += 5
st = "ELITE" if score>=95 else "STRONG" if score>=85 else "MODERATE" if score>=70 else "NEEDS WORK"
print("  Score: %d/100 - %s" % (score, st))
test("Score: " + st, score >= 85)

# Orchestrator checks
print("\n[6] SCRIPT INTEGRITY")
scripts_dir = os.path.join(ROOT, "scripts")

# Check all scripts have param
checks = {
    "client-intake.ps1":"intake", "populate-client-data.ps1":"injection",
    "enforce-no-placeholders.ps1":"enforcement", "validate-compliance-module.ps1":"validation",
    "traceability-validator.ps1":"validation", "policy-domain-validator.ps1":"validation",
    "variable-scanner.ps1":"validation", "generate-compliance-report.ps1":"reporting",
    "remediation-engine.ps1":"reporting", "compliance-dashboard.ps1":"dashboard",
}
no_param = []
for sn, sf in checks.items():
    fp = os.path.join(scripts_dir, sf, sn)
    if not os.path.isfile(fp): continue
    c = open(fp).read()
    if "$modulePath" not in c and "$deploymentsRoot" not in c:
        no_param.append(sn)
test("All scripts parameterized", len(no_param) == 0, str(no_param))

ic = open(os.path.join(ROOT, "initialize-client.ps1")).read()
test("Orchestrator passes -modulePath", "-modulePath $modulePath" in ic)
test("No $clientSystemPath bug", "$clientSystemPath" not in ic)

# Allowlist in enforcement
ec = open(os.path.join(scripts_dir, "enforcement", "enforce-no-placeholders.ps1")).read()
test("Enforcement has allowlist", "$allowlist" in ec)

# Allowlist in scanner
sc = open(os.path.join(scripts_dir, "validation", "variable-scanner.ps1")).read()
test("Scanner has allowlist", "$allowlist" in sc)

# Cleanup
shutil.rmtree(CLIENT_DEPLOY, ignore_errors=True)

print("\n" + "=" * 60)
print("RESULTS: %d passed, %d failed" % (passes, errors))
print("=" * 60)
if errors == 0:
    print("\nALL TESTS PASSED - Production ready")
else:
    print("\n%d ISSUE(S) NEED ATTENTION" % errors)
sys.exit(errors)
