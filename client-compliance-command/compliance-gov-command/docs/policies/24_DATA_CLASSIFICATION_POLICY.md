---
Doc-ID: POL-24
Doc-Name: DATA CLASSIFICATION POLICY
Category: policies
Source-Skill: internal-compliance
Evidence-Required:
  - data_handling_records
Status: template
---

[COMPANY_LEGAL_NAME]
DATA CLASSIFICATION POLICY

Purpose

This Data Classification Policy establishes [COMPANY_LEGAL_NAME]'s requirements for classifying data based on sensitivity, regulatory requirements, and business value. Proper classification ensures data receives appropriate protection controls throughout its lifecycle and supports compliance with applicable laws, regulations, and contractual obligations.

Scope

This policy applies to all [COMPANY_NAME] data in all forms (electronic, physical, verbal) across all systems, platforms, and storage locations. It applies to all personnel, contractors, subcontractors, and third parties who create, collect, process, store, transmit, or dispose of data on behalf of the organization.

Governance and Cross-Package References

This policy implements the data classification framework referenced throughout all [COMPANY_ABBREVIATION] compliance packages. Classification levels defined here drive handling requirements in data-handling-privacy skill and access controls in internal-compliance skill policies.

Universal [COMPANY_ABBREVIATION] Principles:
Data-as-Regulated: [COMPANY_ABBREVIATION] treats ALL client and customer data as regulated by default unless explicitly classified otherwise through this policy's classification process
No Sensitive Data in Logs: Classification labels may appear in logs, but the classified data itself must NOT appear in logs, prompts, debugging output, or monitoring unless encrypted or anonymized

Cross-Package Integration:
security-governance skill (Security & Compliance Handbook): Master governance document establishing data protection framework
data-handling-privacy skill (Data Handling Standard): Implements handling requirements for each classification level defined in this policy
data-handling-privacy skill (Data Lifecycle Management): Retention and disposal requirements by classification level
data-handling-privacy skill (Anonymization Standard): Techniques for de-identifying classified data
internal-compliance skill (Access Control Policy): Access controls mapped to classification levels
internal-compliance skill (Encryption Key Management): Encryption requirements by classification level
internal-compliance skill (Asset Management Policy): Data asset inventory aligned with classification
cloud-platform-security skill (Data Loss Prevention Configuration): Technical controls enforcing classification-based protections

For data handling requirements by classification level, see data-handling-privacy skill (Data Handling Standard).
For data retention by classification, see data-handling-privacy skill (Data Lifecycle Management).
For access control by classification, see internal-compliance skill (Access Control Policy).

Classification Levels

Restricted Data
Definition: Highly sensitive data whose unauthorized disclosure would cause severe harm to the organization, clients, or individuals. Includes data subject to specific regulatory protection requirements.
Examples: Protected Health Information (PHI), Payment Card Industry data (PCI), Controlled Unclassified Information (CUI), Federal Tax Information (FTI), Social Security numbers, financial account numbers, authentication credentials, encryption keys, client trade secrets
Regulatory Drivers: HIPAA, PCI-DSS, NIST 800-171, IRS Publication 1075, GLBA, state breach notification laws
Handling Requirements: Encryption required in transit and at rest (AES-256 minimum), access restricted to named individuals with documented business need, multi-factor authentication required, access logged and monitored, data loss prevention controls enforced, no storage on personal devices, no transmission via unencrypted channels, secure disposal required
Retention: Per regulatory requirement or contract (minimum as required by law)
Incident Response: Breach notification required per applicable regulations within required timeframes

Confidential Data
Definition: Sensitive business or client data whose unauthorized disclosure would cause significant harm to the organization or clients. Includes data shared under confidentiality obligations.
Examples: Client business data, project deliverables, financial reports, contracts, proposals, employee records, internal security assessments, vendor assessments, strategic plans, unpublished intellectual property
Regulatory Drivers: NDA obligations, contractual requirements, GDPR (personal data), CCPA (personal information), employment law
Handling Requirements: Encryption required in transit and at rest, access limited to personnel with business need, strong authentication required, access logged, secure sharing methods required (approved platforms only), no forwarding to personal accounts, controlled printing
Retention: Per contract or business requirement (default 7 years unless specified)
Incident Response: Internal incident response activated; client notification per contract requirements

Internal Data
Definition: Information intended for internal use within the organization. Unauthorized disclosure would cause limited harm.
Examples: Internal policies, procedures, meeting notes, project plans, internal communications, training materials, operational metrics, non-sensitive correspondence
Regulatory Drivers: General business practices, employment law
Handling Requirements: Encryption in transit recommended, access limited to [COMPANY_NAME] personnel, standard authentication required, standard access controls, may be stored on approved platforms, controlled external sharing
Retention: Per business requirement (default 3 years unless specified)
Incident Response: Internal review; escalation if regulatory data discovered

Public Data
Definition: Information approved for public disclosure with no restrictions on distribution.
Examples: Marketing materials, published content, press releases, public website content, published job postings, public financial filings
Regulatory Drivers: None specific
Handling Requirements: No special handling required, no encryption required, available to anyone, standard disposal
Retention: Per business requirement
Incident Response: Not applicable unless data integrity compromised

Classification Process

Data Classification Workflow

Step 1 -- Identify Data
Identify data requiring classification
Consider: Data source, content, purpose, regulatory requirements, contractual obligations
New data classified at creation or receipt
Existing data classified during periodic reviews

Step 2 -- Determine Classification Level
Apply classification criteria based on data sensitivity, regulatory requirements, and business impact
When in doubt, classify at the higher level (Data-as-Regulated principle)
Client data defaults to Confidential unless regulatory requirements dictate Restricted
Government data classified per contract and regulatory requirements (CUI, FTI, etc.)

Step 3 -- Apply Classification Label
Classification label applied to data asset
Electronic data: Metadata tag, header/footer label, folder structure, or system classification field
Physical data: Header/footer marking, cover sheet, container label
Verbal information: Classification stated before sharing sensitive information

Step 4 -- Implement Controls
Handling controls implemented per classification level requirements
Access controls configured per classification level
Encryption applied per classification level
Monitoring and logging configured per classification level

Step 5 -- Document Classification
Classification decision documented in data inventory
Documentation includes: Data description, classification level, data owner, classification rationale, regulatory drivers, review date
Documentation maintained in data asset register

Step 6 -- Review and Reclassify
Classification reviewed when data purpose or context changes
Classification reviewed when regulatory requirements change
Classification reviewed during periodic data inventory reviews
Reclassification documented with rationale

Classification Decision Criteria

Regulatory Analysis
Identify all applicable regulations for the data type
Determine regulatory classification requirements
Apply highest applicable regulatory classification
Document regulatory basis for classification

Contractual Analysis
Review client contracts for data protection requirements
Review NDAs and confidentiality obligations
Apply contractual classification requirements
Document contractual basis for classification

Business Impact Analysis
Assess impact of unauthorized disclosure on organization
Assess impact of unauthorized disclosure on clients
Assess impact of unauthorized disclosure on individuals
Apply classification based on highest potential impact

Default Classification Rules
All client data: Minimum Confidential (elevated to Restricted if PHI, PCI, CUI, FTI, or SSN present)
All employee personal data: Confidential
All financial records: Confidential
All security documentation: Confidential
All authentication credentials: Restricted
All encryption keys: Restricted
All government contract data: Per contract requirements (minimum Confidential)

Data Inventory and Register

Data Asset Register
Centralized register of classified data assets maintained
Register includes: Asset name, description, classification level, data owner, storage location, regulatory drivers, access permissions, retention period, review date
Register reviewed and updated quarterly
Register accessible to CISO and data owners

Data Flow Mapping
Data flows documented showing how classified data moves through systems
Data flow maps identify: Sources, processing points, storage locations, transmission paths, recipients
Data flow maps reviewed for classification-appropriate controls at each point
Data flow maps updated when systems or processes change

Classification Audit
Periodic audit of classification accuracy and completeness
Audit verifies: Classification labels applied, handling controls implemented, access controls appropriate, retention requirements met
Audit findings documented and remediated
Audit conducted annually

Roles and Responsibilities

CISO ([OWNER_NAME])
Overall responsibility for data classification program
Approve Data Classification Policy and updates
Review classification disputes and escalations
Ensure classification program supports compliance requirements
Report classification metrics and issues to management

Data Owners
Classify data within their area of responsibility
Ensure classification labels applied correctly
Ensure handling controls implemented per classification level
Review and update classifications periodically
Report classification issues and incidents

All Personnel
Classify data they create or receive per this policy
Handle data according to its classification level
Report suspected misclassification
Complete data classification training
Protect classified data from unauthorized access or disclosure

IT and Security
Implement technical controls supporting classification (DLP, encryption, access controls, labeling)
Monitor compliance with classification-based controls
Support classification audits
Maintain data asset register and data flow maps

Enforcement

Policy Compliance
Compliance with this policy is mandatory for all personnel
Classification accuracy monitored through audits and reviews
Non-compliance reported and addressed through corrective action

Violations
Intentional misclassification or failure to classify data is a policy violation
Handling data below its required classification level is a policy violation
Violations addressed through disciplinary process
Serious violations may result in termination and legal action

Contact Information

For data classification questions or to report classification issues, contact:

[OWNER_NAME]
Founder and Chief Information Security Officer
[COMPANY_LEGAL_NAME]
Email: [CONTACT_EMAIL]
Phone: [CONTACT_PHONE]
[COMPANY_CITY], [GOVERNING_STATE]

UEI: [COMPANY_UEI]
CAGE Code: [COMPANY_CAGE_CODE]
