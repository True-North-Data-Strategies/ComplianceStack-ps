# Shared Questionnaire

`questionnaire.json` at the root of this stack is the **single source of truth** for intake fields. The matching file in `compliancestack-ps/` is a copy — when the spec changes, edit one and copy to the other.

## Field shape

```json
{
  "id": "companyLegalName",
  "label": "Company Legal Name",
  "example": "Acme Federal Services LLC",
  "type": "text",
  "required": true,
  "ps_token": "COMPANY_LEGAL_NAME",
  "ts_token": "COMPANY_NAME",
  "ts_field": "companyName"
}
```

- `ps_token` — what the PowerShell injector looks for as `[COMPANY_LEGAL_NAME]` in `.md`/`.txt` docs. `null` means field is TS-only.
- `ts_token` — what the TS Handlebars engine looks for as `{{COMPANY_NAME}}`. `null` means field is PS-only.
- `ts_field` — camelCase key posted to `/api/compliance/submit-company-info` (TS-only).
- `example` — shown as the input placeholder in the web form and next to the prompt in the PS script.

## TS usage

```tsx
import { QuestionnaireForm } from "@commandstack/mod-compliance-command/ui";
import "@commandstack/mod-compliance-command/ui/questionnaire-form.css";

export default function Page() {
  return <QuestionnaireForm submitUrl="/api/compliance/submit-company-info" />;
}
```

The form reads `questionnaire.json` at build time, renders every section with example text under each input, and POSTs a flat camelCase payload matching `CompanyInput` in `company-service.ts`.

## PS usage

```powershell
.\scripts\intake\questionnaire-intake.ps1 -modulePath "C:\...\deployments\acme\compliance-gov-command"
```

The script loops every field that has a `ps_token`, shows the example value next to the prompt, accepts defaults on Enter, and writes `client-variable-map.json` into the module path. `populate-client-data.ps1` then consumes that map as usual.
