<!-- TNDS-HEADER:BEGIN -->
<div align="center">
  <h1>ComplianceStack-ps</h1>
  <h3>Builds a client-branded government compliance packet from one questionnaire, then stops if any company placeholder is left unfilled.</h3>
  <img src="https://raw.githubusercontent.com/Jjohnston70/Jjohnston70/main/true-north-logo-layered-v3.png" alt="True North Data Strategies" width="240" />
  <br /><br />
  <a href="#stack"><img src="https://img.shields.io/badge/Built%20with-PowerShell%20%7C%20Python-0A8EA0?style=for-the-badge" alt="Built with PowerShell | Python" /></a>
  <a href="https://truenorthstrategyops.com"><img src="https://img.shields.io/badge/Built%20by-TNDS-1F6FEB?style=for-the-badge" alt="Built by TNDS" /></a>
  <a href="#contact"><img src="https://img.shields.io/badge/Contact-TNDS-181717?style=for-the-badge" alt="Contact" /></a>
</div>
<!-- TNDS-HEADER:END -->

## What this is

Small businesses going after federal work get asked for the same stack of paper: an information security policy, an incident response plan, access control, vendor management, a capability statement. ComplianceStack-ps produces that stack for one company at a time. You answer one intake questionnaire, the scripts write the answers into every document, the run stops if any company placeholder is left unfilled, and the finished packet is scored for completeness.

Each client gets an isolated copy under `deployments\<client>\`. Nothing is shared between clients, and client data never enters this repository.

| Path | What it holds |
|---|---|
| `client-compliance-command/compliance-gov-command/docs/` | The client template. Every company detail is a `[TOKEN]`, 69 distinct tokens in all. |
| `compliance-gov-command/docs/` | The same document set already filled in for True North Data Strategies, as a worked example. |
| `scripts/` | Intake, injection, enforcement, validation, reporting and a multi-client dashboard. |
| `questionnaire.json` | The intake questions in structured form. `QUESTIONNAIRE.md` explains the field format. |

## What is in the packet

| Folder | What it covers | Files |
|---|---|---|
| `policies/` | Information security, acceptable use, access control, incident response, continuity and disaster recovery, encryption, passwords, remote access, mobile and BYOD, vendor risk, AI governance, data classification and more | 31 |
| `procedures/` | Employee and client onboarding and offboarding, a government-edition contingency plan, NIST-lite alignment, mandatory reporting, quality assurance, document control, procurement and subcontracting | 15 |
| `frameworks/` | Cloud workspace, platform, IAM, AI governance, data loss prevention and security monitoring standards, a cloud partner statement and a security compliance handbook | 8 |
| `templates/` | Services agreement, statement of work, data processing, business associate, nondisclosure and service level agreements, plus security questionnaire, audit checklist, risk assessment, vendor assessment, tabletop exercise, incident report, risk register and audit log templates | 15 |
| `research/` | The research notes behind the documents | 8 |
| `artifacts/` | Capability statement and government readiness statement | 2 |
| `evidence/` | `restricted/` and `business/` folders, empty in the template | 0 |

## Current state

| Check | Result |
|---|---|
| `test-system.py`: deploy, inject, enforce, score and a script audit | 20 passed, 0 failed, run 2026-10-19 |
| `test-system-v2.py`: full variable map plus the table-header allowlist | 10 passed, 0 failed, run 2026-10-19. Every client token resolves; completeness score 98 of 100 |
| `test-system.ps1`: the PowerShell pipeline end to end | Not run in this review. It needs Windows PowerShell |

Known limits, stated plainly:

- The score counts folders and documents. It says whether the packet is complete, not whether the company follows it. It is not an audit, an assessment or a certification.
- The traceability check flags any policy that still says TBD. The domain check applies four file-name rules: access, incident, vendor and backup.
- Paths are written for Windows, for example `docs\policies`.
- `add-policy-metadata.ps1` and the three `auto-link-policies` scripts were written for an earlier `.txt` version of the policy set. They skip the current `.md` files.
- `run-all-tests.ps1` looks for Apps Script test files and does not test this repository.

## Start here

1. On Windows, open PowerShell in the repository root.
2. Run `.\initialize-client.ps1` and give the client a folder name with dashes and no spaces.
3. Answer the intake prompts. Type TBD where a value is not known yet.
4. Read the report saved under `deployments\<client>\compliance-gov-command\data\`.

What `initialize-client.ps1` does, in order:

| Step | What happens | Stops the run when |
|---|---|---|
| Deploy | Copies the client template into `deployments\<client>\` | The template carries any evidence file, or the client folder already exists |
| Intake | Prompts for company details and writes `client-variable-map.json` | Intake fails |
| Inject | Replaces every `[TOKEN]` in the packet | Injection fails |
| Provider check | Looks for the provider's own name and documents in the client packet | The packet names True North Data Strategies or carries a `TNDS_` document, unless the client is True North itself |
| Enforce | Looks for any client token left unresolved. Table headers such as `[STATUS]` are allowed | A client token remains |
| Validate | Runs the structure, traceability and domain checks | Never; it reports |
| Remediate | Lists missing policies, templates and evidence folders | Never; it reports |
| Report | Writes the completeness score and document counts to a dated text file | Never |

To re-check one client later, run `.\run-compliance.ps1 -modulePath "deployments\<client>\compliance-gov-command"`. To check every client at once, run `.\scripts\dashboard\compliance-dashboard.ps1`. For intake with an example shown next to every prompt, run `.\scripts\intake\questionnaire-intake.ps1`, which reads `questionnaire.json`.

## Local setup and verification

| Need | For |
|---|---|
| Windows PowerShell | Every `.ps1` script |
| Python 3 | The two integration tests |

```
python3 test-system.py
python3 test-system-v2.py
```

Both tests create a throwaway client under `deployments\` and delete it when they finish. Nothing in this repository uses credentials or API keys.

## Data and access

| Rule | Where it is enforced |
|---|---|
| Intake answers stay with the client | `.gitignore` excludes `client-variable-map.json` and `deployments/` |
| Evidence lives only in a client deployment, never in the template | `.gitignore`, and `initialize-client.ps1` refuses a template that carries evidence files |
| Sensitive evidence goes in `docs\evidence\restricted\`, general records in `docs\evidence\business\` | The client template README |
| The provider's name and documents never ship to a client | The provider check in `initialize-client.ps1` |
| Generated reports stay local | `.gitignore` excludes `compliance-report-*.txt` |

This is a public repository. It holds template text and synthetic test data only.

## Stack

| Layer | Tools |
|---|---|
| Scripts | PowerShell |
| Tests | Python 3, PowerShell |
| Documents | Markdown, plus a Word user manual for the client template |
| Intake data | JSON |

<!-- TNDS-FOOTER:BEGIN -->
## Contact

Jacob Johnston | True North Data Strategies LLC, SDVOSB | Colorado Springs, Colorado

jacob@truenorthstrategyops.com | [truenorthstrategyops.com](https://truenorthstrategyops.com) | [pipelinepunks.com](https://pipelinepunks.com)

_Last reviewed 2026-10-19._
<!-- TNDS-FOOTER:END -->
