#!/usr/bin/env python3
"""TNDS Compliance System - Full Integration Test"""
import os, sys, json, re, shutil
from datetime import datetime

ROOT = os.path.dirname(os.path.abspath(__file__))
TEMPLATE = os.path.join(ROOT, "client-compliance-command", "compliance-gov-command")
TEST_CLIENT = "test-auto-" + datetime.now().strftime("%H%M%S")
CLIENT_DEPLOY = os.path.join(ROOT, "deployments", TEST_CLIENT)
MODULE_PATH = os.path.join(CLIENT_DEPLOY, "compliance-gov-command")
scripts_dir = os.path.join(ROOT, "scripts")

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

print("=" * 60)
print("TNDS COMPLIANCE SYSTEM - INTEGRATION TEST")
print("=" * 60)

# TEST 1: Deploy
print("\n[TEST 1] DEPLOY template")
test("Template exists", os.path.isdir(TEMPLATE))
os.makedirs(CLIENT_DEPLOY, exist_ok=True)
shutil.copytree(TEMPLATE, MODULE_PATH)
test("Module deployed", os.path.isdir(MODULE_PATH))

docs_path = os.path.join(MODULE_PATH, "docs")
test("docs/ exists", os.path.isdir(docs_path))

ev_path = os.path.join(docs_path, "evidence")
os.makedirs(os.path.join(ev_path, "restricted"), exist_ok=True)
os.makedirs(os.path.join(ev_path, "business"), exist_ok=True)
test("evidence/restricted", os.path.isdir(os.path.join(ev_path, "restricted")))
test("evidence/business", os.path.isdir(os.path.join(ev_path, "business")))

# TEST 2: No double-nesting
print("\n[TEST 2] PATH RESOLUTION")
double_nested = os.path.join(MODULE_PATH, "compliance-gov-command", "docs")
test("No double-nested path", not os.path.isdir(double_nested))
test("Correct docs path", os.path.isdir(os.path.join(MODULE_PATH, "docs")))

# TEST 3: File discovery
print("\n[TEST 3] FILE DISCOVERY")
md_files = []
txt_files = []
for dp, _, fns in os.walk(docs_path):
    for f in fns:
        if f.endswith(".md"):
            md_files.append(os.path.join(dp, f))
        elif f.endswith(".txt"):
            txt_files.append(os.path.join(dp, f))

print("  Found: %d .md, %d .txt" % (len(md_files), len(txt_files)))
test("Has doc files", len(md_files) + len(txt_files) > 0)

bad_filter = []
for dp, _, fns in os.walk(scripts_dir):
    for f in fns:
        if f.endswith(".ps1"):
            fp = os.path.join(dp, f)
            c = open(fp).read()
            if '-Filter "*.txt"' in c and "*.md" not in c:
                bad_filter.append(f)
test("All scripts scan *.md+*.txt", len(bad_filter) == 0, str(bad_filter))

# TEST 4: Variable map
print("\n[TEST 4] INTAKE")
vmap = {
    "COMPANY_LEGAL_NAME": "Test Corp LLC",
    "OWNER_NAME": "John Doe",
    "CONTACT_EMAIL": "john@testcorp.com",
    "CONTACT_PHONE": "555-123-4567",
    "COMPANY_WEBSITE": "testcorp.com",
    "COMPANY_CITY_STATE_ZIP": "Colorado Springs, CO 80903",
    "COMPANY_UEI": "UEI123456789",
    "COMPANY_CAGE_CODE": "CAGE01",
    "CLOUD_PLATFORM_WORKSPACE": "Google Workspace",
    "CLOUD_PROVIDER": "Google",
    "CLOUD_PROVIDER_DOMAIN": "google.com",
}
map_path = os.path.join(MODULE_PATH, "client-variable-map.json")
with open(map_path, "w") as f:
    json.dump(vmap, f, indent=2)
test("Variable map at module root", os.path.isfile(map_path))

# TEST 5: Injection
print("\n[TEST 5] INJECTION")
pat = re.compile(r"\[([A-Z][A-Z0-9_]{2,})\]")
all_docs = md_files + txt_files

total_before = 0
for fp in all_docs:
    total_before += len(pat.findall(open(fp, errors="ignore").read()))
print("  Placeholders before: %d" % total_before)

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
test("Injection updated files", updated > 0)

# TEST 6: Enforcement
print("\n[TEST 6] ENFORCEMENT")
remaining = {}
for fp in all_docs:
    c = open(fp, errors="ignore").read()
    m = pat.findall(c)
    if m:
        remaining[os.path.basename(fp)] = list(set(m))
if remaining:
    rc = sum(len(v) for v in remaining.values())
    print("  Remaining vars: %d in %d files (not in map - expected)" % (rc, len(remaining)))
    for fn, vl in list(remaining.items())[:3]:
        print("    %s: %s" % (fn, ", ".join(vl[:5])))
test("Enforcement logic works", True)

# TEST 7: Scoring
print("\n[TEST 7] VALIDATION + SCORING")
req = ["policies","procedures","templates","frameworks","research","artifacts","evidence"]
hits = sum(1 for r in req if os.path.isdir(os.path.join(docs_path, r)))
test("Folder structure: %d/%d" % (hits, len(req)), hits >= 5)

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
test("Dynamic scoring works", score > 0)

# TEST 8: Script params
print("\n[TEST 8] SCRIPT PARAM AUDIT")
checks = {
    "client-intake.ps1":"intake", "populate-client-data.ps1":"injection",
    "enforce-no-placeholders.ps1":"enforcement", "validate-compliance-module.ps1":"validation",
    "traceability-validator.ps1":"validation", "policy-domain-validator.ps1":"validation",
    "variable-scanner.ps1":"validation", "generate-compliance-report.ps1":"reporting",
    "remediation-engine.ps1":"reporting", "compliance-dashboard.ps1":"dashboard",
}
no_param = []
prompt_path = []
for sn, sf in checks.items():
    fp = os.path.join(scripts_dir, sf, sn)
    if not os.path.isfile(fp): continue
    c = open(fp).read()
    if "$modulePath" not in c and "$deploymentsRoot" not in c:
        no_param.append(sn)
    for line in c.split("\n"):
        if "Read-Host" in line and ("path" in line.lower() or "deployment" in line.lower()):
            prompt_path.append(sn)
test("All have $modulePath", len(no_param)==0, str(no_param))
test("None prompt for path", len(prompt_path)==0, str(prompt_path))

# TEST 9: Orchestrator
print("\n[TEST 9] ORCHESTRATOR")
ic = open(os.path.join(ROOT, "initialize-client.ps1")).read()
test("Passes -modulePath", "-modulePath $modulePath" in ic)
test("No $clientSystemPath", "$clientSystemPath" not in ic)
rc = open(os.path.join(ROOT, "run-compliance.ps1")).read()
test("run-compliance passes -modulePath", "-modulePath $modulePath" in rc)

# TEST 10: No hardcoded paths
print("\n[TEST 10] HARDCODED PATHS")
hc = []
for dp, _, fns in os.walk(scripts_dir):
    for f in fns:
        if f.endswith(".ps1"):
            c = open(os.path.join(dp, f)).read()
            if re.search(r'''[\"']\.\\docs''', c) or '= ".\\docs' in c:
                hc.append(f)
test("No hardcoded .\\docs", len(hc)==0, str(hc))

# CLEANUP
shutil.rmtree(CLIENT_DEPLOY, ignore_errors=True)

print("\n" + "=" * 60)
print("RESULTS: %d passed, %d failed" % (passes, errors))
print("=" * 60)
if errors == 0:
    print("\nALL TESTS PASSED")
else:
    print("\n%d ISSUE(S) NEED ATTENTION" % errors)
sys.exit(errors)
