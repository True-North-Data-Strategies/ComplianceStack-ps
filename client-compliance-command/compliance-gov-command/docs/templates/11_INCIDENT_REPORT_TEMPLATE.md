---
Doc-ID: TMPL-11
Doc-Name: INCIDENT REPORT TEMPLATE
Category: templates
Source-Skill: contracts-risk-assurance
Evidence-Required:
  - incident_records
Status: template
---

[COMPANY_LEGAL_NAME]
INCIDENT REPORT TEMPLATE

Purpose

This Incident Report Template provides [COMPANY_LEGAL_NAME] with a standardized format for documenting security incidents from initial detection through resolution and post-incident review. This template ensures consistent, thorough incident documentation that supports compliance, legal, and improvement requirements.

Scope

This template applies to all [COMPANY_NAME] security incidents including data breaches, unauthorized access, malware infections, denial of service, insider threats, physical security incidents, and policy violations. It applies to all personnel involved in incident response and documentation.

Governance and Cross-Package References

This template supports incident documentation requirements across all [COMPANY_ABBREVIATION] compliance packages.

Universal [COMPANY_ABBREVIATION] Principles - Incident Documentation:
No Sensitive Data in Logs: Incident reports must NOT contain actual PII, PHI, PCI, CUI, or other regulated identifiers; use anonymized references (e.g., "Employee A," "Client X," "Record ID: [REDACTED]")
Data-as-Regulated: All incident report data treated as Confidential; access restricted to incident response team and authorized personnel

Cross-Package Integration:
internal-compliance skill (Incident Response Plan): Defines incident response procedures this template supports
data-handling-privacy skill (Breach Notification Procedure): Breach notification requirements triggered by incident findings
internal-compliance skill (Audit Logging and Monitoring Policy): Log sources referenced in incident investigation
contracts-risk-assurance skill (Incident Response Tabletop Exercise Guide): Template used during exercises for realistic documentation practice

For incident response procedures, see internal-compliance skill (Incident Response Plan).
For breach notification requirements, see data-handling-privacy skill (Breach Notification Procedure).

Incident Report

Incident Identification

Incident Report Number
[IR-YYYY-NNN]

Incident Title
[Enter brief descriptive title]

Report Date
[Enter date report created]

Report Author
[Enter author name and title]

Incident Status
[Open, Investigating, Contained, Eradicated, Recovered, Closed]

Incident Severity
[Critical, High, Medium, Low]

Incident Classification
[Data Breach, Unauthorized Access, Malware/Ransomware, Denial of Service, Insider Threat, Phishing/Social Engineering, Physical Security, Policy Violation, System Compromise, Other]

Incident Detection

Date and Time Detected
[Enter date and time incident was detected]

Detection Method
[Automated monitoring/alert, Employee report, Client report, Third-party notification, Audit finding, Law enforcement notification, Other]

Detected By
[Enter name and role of person or system that detected incident]

Initial Indicators
[Describe initial indicators or symptoms that triggered detection]

Incident Timeline

Initial Detection
[Date/Time]: [Description of detection event]

Notification and Escalation
[Date/Time]: [Who was notified and when]

Investigation Initiated
[Date/Time]: [Investigation actions taken]

Containment Actions
[Date/Time]: [Containment measures implemented]

Eradication Actions
[Date/Time]: [Threat removal and remediation actions]

Recovery Actions
[Date/Time]: [System and data recovery actions]

Incident Closed
[Date/Time]: [Confirmation of incident resolution]

Incident Description

Summary
[Provide detailed narrative description of the incident: What happened, how it happened, what was affected]

Systems Affected
[List affected systems, applications, and infrastructure]

Data Affected
[Describe data types affected: Classification level, data categories, volume]
[Note: Do NOT include actual PII, PHI, PCI, CUI -- use anonymized references]

Users Affected
[Number and categories of affected users: Employees, clients, third parties]
[Note: Do NOT include actual names or identifiers -- use anonymized references]

Geographic Scope
[Locations or regions affected]

Root Cause Analysis

Root Cause
[Describe the root cause of the incident]

Contributing Factors
[List factors that contributed to the incident occurring or increasing its impact]

Attack Vector (if applicable)
[Describe how the threat actor gained access or initiated the incident]

Vulnerabilities Exploited
[Describe vulnerabilities or weaknesses that were exploited]

Containment and Eradication

Containment Actions
[List all containment actions taken to stop the incident from spreading]

Eradication Actions
[List all actions taken to remove the threat and remediate vulnerabilities]

Evidence Preserved
[Describe evidence collected and preserved: Logs, images, artifacts]
[Note: Evidence stored securely with chain of custody documented]

Recovery

Recovery Actions
[List all actions taken to restore systems and data to normal operations]

Data Recovery
[Describe data recovery actions: Backups restored, data integrity verified]

System Verification
[Describe verification that systems are clean and operational]

Normal Operations Restored
[Date/Time normal operations confirmed restored]

Impact Assessment

Business Impact
[Describe impact on business operations: Downtime, productivity loss, service disruption]

Financial Impact
[Estimated financial impact: Direct costs, indirect costs, potential liability]

Regulatory Impact
[Regulatory implications: Breach notification requirements triggered, compliance violations, potential fines]

Reputational Impact
[Potential or actual reputational impact: Client relationships, public exposure, media attention]

Client Impact
[Impact on clients: Data affected, services disrupted, notifications required]

Notifications

Internal Notifications
[List internal personnel and management notified with dates]

Client Notifications
[List client notifications made or required with dates and method]

Regulatory Notifications
[List regulatory notifications made or required: Authority, date, method, reference number]

Law Enforcement Notifications
[List law enforcement notifications made or required]

Third-Party Notifications
[List other third-party notifications: Vendors, partners, insurance]

Lessons Learned

What Worked Well
[Describe aspects of incident response that were effective]

What Could Be Improved
[Describe aspects of incident response that need improvement]

Gaps Identified
[Describe gaps in policies, procedures, controls, or capabilities identified]

Recommendations
[List specific recommendations for improving security and incident response]

Corrective Actions

Corrective Action Plan
[Action Item 1]: [Description, Owner, Due Date, Status]
[Action Item 2]: [Description, Owner, Due Date, Status]
[Action Item 3]: [Description, Owner, Due Date, Status]

Preventive Measures
[List measures to prevent similar incidents in the future]

Policy or Procedure Updates
[List policies or procedures that need to be updated based on lessons learned]

Approvals

Report Prepared By
Name: [Enter name]
Title: [Enter title]
Date: [Enter date]
Signature: [Enter signature]

Report Reviewed By
Name: [Enter name]
Title: [Enter title]
Date: [Enter date]
Signature: [Enter signature]

Report Approved By
Name: [OWNER_NAME]
Title: Chief Information Security Officer
Date: [Enter date]
Signature: [Enter signature]

Distribution

This incident report is classified as Confidential and distributed to:
[List authorized recipients]

Report retained per records retention policy (minimum 7 years for incidents involving regulated data).

Contact Information

For incident reporting or incident response questions, contact:

[OWNER_NAME]
Founder and Chief Information Security Officer
[COMPANY_LEGAL_NAME]
Email: [CONTACT_EMAIL]
Phone: [CONTACT_PHONE]

UEI: [COMPANY_UEI]
CAGE Code: [COMPANY_CAGE_CODE]
