<!-- TNDS-HEADER:BEGIN -->
<div align="center">
  <h1>ComplianceStack-ps</h1>
  <h3>Compliance policy library with PowerShell tooling to fill, validate and report on a client's policy set.</h3>
  <img src="https://raw.githubusercontent.com/Jjohnston70/Jjohnston70/main/PPD%20no%20badge.png" alt="Pipeline Punks" width="240" />
  <br /><br />
  <a href="#stack"><img src="https://img.shields.io/badge/Built%20with-PowerShell%20%7C%20Python-0A8EA0?style=for-the-badge" alt="Built with PowerShell | Python" /></a>
  <a href="https://truenorthstrategyops.com"><img src="https://img.shields.io/badge/Built%20by-TNDS-1F6FEB?style=for-the-badge" alt="Built by TNDS" /></a>
  <a href="https://pipelinepunks.com"><img src="https://img.shields.io/badge/Pipeline-Punks-181717?style=for-the-badge" alt="Pipeline Punks" /></a>
</div>
<!-- TNDS-HEADER:END -->

## What This Is

A private working repository that holds a full compliance document set and the PowerShell scripts that work on it. The documents cover policies, procedures, cloud security frameworks, contract templates and research notes. The scripts take in client details, write them into the documents, check the result and produce a compliance report.

The document set sits in `compliance-gov-command/docs/`. A copy of it sits under `client-compliance-command/`, which also has its own `README.md` and a user manual in `.docx` form.

This README is written from the file list only. The repository documents no status, so none is claimed. The script descriptions below come from file names and folder layout. Read each script's header before you run it.

## What Is In the Document Set

| Folder | What it holds | Count |
|---|---|---|
| `docs/policies/` | Numbered security, privacy, continuity, vendor, access and AI governance policies | 31 files |
| `docs/procedures/` | Onboarding, offboarding, contingency, reporting, quality, document control and procurement procedures, including government-edition documents | 15 files |
| `docs/frameworks/` | Cloud workspace, platform, IAM, AI governance, data loss prevention and monitoring standards, plus a security compliance handbook | 7 numbered files and the handbook |
| `docs/templates/` | Agreement, assessment, checklist, incident and register templates | 15 files |
| `docs/research/` | Research notes behind the documents | 8 files |
| `docs/artifacts/` | Capability statement and government readiness statement | 2 files |
| `docs/evidence/` | Evidence folders, `business` and `restricted`, held open with `.gitkeep` | 2 folders |

## Scripts

| Name | What it does | Built with |
|---|---|---|
| `run-compliance.ps1` | Top-level entry script for the compliance run | PowerShell |
| `run-all-tests.ps1` | Runs the test scripts together | PowerShell |
| `initialize-client.ps1` | Sets up a new client | PowerShell |
| `deploy-compliance-command.ps1` | Deploys the compliance module | PowerShell |
| `deploy-command.ps1` | Deploy script | PowerShell |
| `normalize-module.ps1` | Normalizes the module files | PowerShell |
| `add-policy-metadata.ps1` | Adds metadata to policy documents | PowerShell |
| `auto-link-policies.ps1`, `auto-link-policies-v2.ps1`, `auto-link-policies-v2_1.ps1` | Links policies to each other, in three versions | PowerShell |
| `scripts/intake/client-intake.ps1` | Collects client details | PowerShell |
| `scripts/intake/questionnaire-intake.ps1` | Reads questionnaire answers | PowerShell |
| `scripts/injection/populate-client-data.ps1` | Writes client data into the documents | PowerShell |
| `scripts/enforcement/enforce-no-placeholders.ps1` | Enforces that no placeholders are left in the documents | PowerShell |
| `scripts/validation/validate-compliance-module.ps1` | Validates the compliance module | PowerShell |
| `scripts/validation/policy-domain-validator.ps1` | Validates policies by domain | PowerShell |
| `scripts/validation/traceability-validator.ps1` | Checks traceability between documents | PowerShell |
| `scripts/validation/variable-scanner.ps1` | Scans documents for variables | PowerShell |
| `scripts/reporting/generate-compliance-report.ps1` | Generates the compliance report | PowerShell |
| `scripts/reporting/remediation-engine.ps1` | Produces remediation items | PowerShell |
| `scripts/dashboard/compliance-dashboard.ps1` | Compliance dashboard | PowerShell |
| `test-system.ps1`, `test-system.py`, `test-system-v2.py` | System tests | PowerShell, Python |

## Intake Files

| File | What it holds |
|---|---|
| `QUESTIONNAIRE.md` | The client questionnaire, in readable form |
| `questionnaire.json` | The questionnaire in structured form |

## Stack

| Layer | Tools |
|---|---|
| Scripting | PowerShell |
| Testing | PowerShell, Python |
| Documents | Markdown, Word (`.docx`) |
| Data | JSON |

<!-- TNDS-FOOTER:BEGIN -->
## Contact

Jacob Johnston | True North Data Strategies LLC, SDVOSB | Colorado Springs, Colorado

jacob@truenorthstrategyops.com | [truenorthstrategyops.com](https://truenorthstrategyops.com) | [pipelinepunks.com](https://pipelinepunks.com)

_Maintained by the TNDS README steward. Last reviewed 2026-10-17._
<!-- TNDS-FOOTER:END -->
