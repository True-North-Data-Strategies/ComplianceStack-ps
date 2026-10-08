---
Doc-ID: POL-22
Doc-Name: VENDOR RISK ASSESSMENT POLICY
Category: policies
Source-Skill: internal-compliance
Evidence-Required:
  - vendor_assessments
  - risk_assessments
Status: template
---

[COMPANY_LEGAL_NAME]
VENDOR RISK ASSESSMENT POLICY

Purpose

This Vendor Risk Assessment Policy establishes [COMPANY_LEGAL_NAME]'s requirements for systematically assessing, scoring, and documenting security and compliance risks associated with vendors and third parties before engagement and throughout the vendor relationship. This policy ensures vendor risks are identified, evaluated, and mitigated to protect organizational and client data.

Scope

This policy applies to all [COMPANY_NAME] vendor and third-party risk assessments. It applies to all personnel involved in vendor evaluation, selection, and ongoing risk monitoring. This policy covers all vendor categories including cloud service providers, software vendors, consultants, subcontractors, and service providers.

Governance and Cross-Package References

This policy operates under the authority of the Security and Compliance Handbook (security-governance skill), which establishes the master governance framework for third-party risk management.

Universal [COMPANY_ABBREVIATION] Principles:
Data-as-Regulated: [COMPANY_ABBREVIATION] treats all client and customer data as regulated by default; vendors accessing any data must be assessed for adequate data protection controls
No Sensitive Data in Logs: Vendor risk assessment documentation must not contain PII, PHI, PCI, CUI, or other regulated identifiers in unprotected form; use anonymized references where possible

Cross-Package Integration:
security-governance skill (Security & Compliance Handbook): Master governance document establishing vendor risk management requirements
internal-compliance skill (Vendor Management Policy): Establishes vendor lifecycle management; this policy provides the risk assessment methodology
data-handling-privacy skill (Data Handling Standard): Data classification requirements that drive vendor risk levels
contracts-risk-assurance skill (Vendor Security Assessment Template): Standardized vendor security questionnaire
contracts-risk-assurance skill (Data Processing Agreement Template): Required for vendors processing personal data
contracts-risk-assurance skill (Business Associate Agreement Template): Required for vendors processing PHI

For vendor lifecycle management, see internal-compliance skill (Vendor Management Policy).
For vendor security questionnaire, see contracts-risk-assurance skill (Vendor Security Assessment Template).
For data classification that drives vendor risk levels, see data-handling-privacy skill (Data Handling Standard).

Vendor Risk Assessment Principles

Risk-Based Tiering
Vendors categorized based on data access, system access, and service criticality
Higher-risk vendors subject to more rigorous and frequent assessment
Risk tier determines assessment depth, frequency, and oversight requirements
Risk tier reviewed and updated when vendor scope changes

Standardized Methodology
Consistent risk assessment methodology applied to all vendors
Assessment criteria documented and repeatable
Scoring criteria transparent and defensible
Assessment results comparable across vendors

Evidence-Based Assessment
Risk assessments supported by documented evidence
Vendor certifications, audit reports, and questionnaires collected
Self-attestation supplemented by independent verification where possible
Evidence retained per retention policy

Continuous Risk Monitoring
Risk assessment not a one-time activity
Vendor risk monitored throughout relationship lifecycle
Trigger events prompt reassessment
Risk trends tracked over time

Vendor Risk Classification

Risk Tier Definitions

Critical Risk Vendors
Access to Restricted or Confidential data (PII, PHI, PCI, CUI, FTI)
Direct access to production systems or infrastructure
Provide services essential to business operations or client delivery
Single point of failure with no immediate alternative
Examples: Cloud infrastructure providers, managed security providers, payroll processors, EHR systems

High Risk Vendors
Access to Internal or Confidential data
Access to non-production systems or development environments
Provide important but not sole-source business services
Disruption would significantly impact operations within 48 hours
Examples: Software-as-a-Service platforms, IT consultants, professional services firms, recruiting agencies

Medium Risk Vendors
Limited or indirect access to Internal data
No direct system access
Provide standard business services with available alternatives
Disruption manageable within normal business operations
Examples: Marketing platforms, training providers, office equipment vendors, accounting software

Low Risk Vendors
No access to company or client data
No system access
Provide commodity services easily replaced
Disruption has negligible operational impact
Examples: Office supply vendors, janitorial services, general contractors, catering

Risk Assessment Process

Pre-Engagement Assessment

Step 1 -- Identify Assessment Scope
Define vendor services and deliverables
Identify data types vendor will access or process
Identify systems vendor will access
Determine service criticality
Document assessment scope

Step 2 -- Assign Preliminary Risk Tier
Assign preliminary risk tier based on data access, system access, and service criticality
Preliminary tier determines assessment depth
Critical and High Risk vendors require full assessment
Medium Risk vendors require standard assessment
Low Risk vendors require abbreviated assessment

Step 3 -- Distribute Security Questionnaire
Send standardized security questionnaire to vendor (see contracts-risk-assurance skill Vendor Security Assessment Template)
Questionnaire covers: Security governance, access control, data protection, encryption, incident response, business continuity, compliance, personnel security
Vendor completes and returns questionnaire with supporting documentation
Questionnaire responses reviewed by CISO or designee

Step 4 -- Collect Supporting Evidence
Request vendor certifications: SOC 2 Type II, ISO 27001, FedRAMP, HITRUST, PCI-DSS as applicable
Request recent penetration test results or vulnerability scan summaries
Request business continuity and disaster recovery documentation
Request insurance certificates (cyber liability, E&O, general liability)
Document all evidence received

Step 5 -- Conduct Risk Scoring
Score vendor across assessment domains (see Risk Scoring Methodology below)
Calculate overall risk score
Compare risk score against acceptance thresholds
Document scoring rationale

Step 6 -- Determine Risk Treatment
Accept: Vendor risk within acceptable threshold; proceed with engagement
Mitigate: Vendor risk above threshold but manageable with additional controls; document required mitigations
Transfer: Risk transferred through contractual protections, insurance requirements, or indemnification
Reject: Vendor risk unacceptable; do not proceed with engagement

Step 7 -- Document and Approve
Complete vendor risk assessment report
Critical Risk vendors: CISO approval required
High Risk vendors: CISO approval required
Medium Risk vendors: Department manager approval with CISO notification
Low Risk vendors: Department manager approval
Approved assessment retained in vendor management records

Risk Scoring Methodology

Assessment Domains

Security Governance (Weight: 15%)
Information security program maturity
Security policies and procedures
Security leadership and accountability
Security awareness and training
Risk management program

Access Control and Authentication (Weight: 15%)
Identity and access management
Multi-factor authentication implementation
Privileged access management
Access review and certification
Least privilege enforcement

Data Protection (Weight: 20%)
Data classification and handling
Encryption (transit and at rest)
Data loss prevention controls
Data retention and disposal
Privacy compliance (GDPR, CCPA, HIPAA as applicable)

Infrastructure and Network Security (Weight: 10%)
Network segmentation and firewalls
Intrusion detection and prevention
Endpoint protection
Vulnerability management and patching
Cloud security controls

Incident Response (Weight: 15%)
Incident response plan and team
Incident detection and monitoring
Incident notification procedures (within 24 hours for Critical vendors)
Incident response testing
Breach notification compliance

Business Continuity (Weight: 10%)
Business continuity and disaster recovery plans
Recovery time and point objectives
Backup and recovery testing
Redundancy and failover capabilities
Supply chain resilience

Compliance and Certifications (Weight: 15%)
Regulatory compliance (GDPR, HIPAA, PCI-DSS, NIST as applicable)
Industry certifications (SOC 2, ISO 27001, FedRAMP, HITRUST)
Audit history and findings
Compliance monitoring and reporting
Subcontractor and fourth-party risk management

Scoring Scale
5 - Excellent: Mature controls, independently verified, exceeds requirements
4 - Good: Established controls, documented, meets requirements
3 - Adequate: Basic controls in place, some gaps, meets minimum requirements
2 - Below Standard: Significant gaps, incomplete controls, does not meet requirements
1 - Unacceptable: No controls, no documentation, critical deficiencies

Risk Acceptance Thresholds
Critical Risk Vendors: Minimum weighted score of 4.0 required
High Risk Vendors: Minimum weighted score of 3.5 required
Medium Risk Vendors: Minimum weighted score of 3.0 required
Low Risk Vendors: Minimum weighted score of 2.5 required

Ongoing Risk Assessment

Reassessment Schedule
Critical Risk vendors reassessed annually (full assessment)
High Risk vendors reassessed annually (standard assessment)
Medium Risk vendors reassessed every two years
Low Risk vendors reassessed every three years or upon significant change

Trigger-Based Reassessment
Security incident involving vendor
Vendor data breach or public security event
Significant change in vendor services or data access
Vendor merger, acquisition, or leadership change
Vendor loss of certification or compliance status
Regulatory change affecting vendor requirements
Client or contract requirement change

Continuous Monitoring
Vendor security posture monitored through available threat intelligence
Vendor compliance status tracked
Vendor performance against SLAs monitored
Vendor incident reports reviewed
Monitoring findings documented and addressed

Annual Risk Review
Annual review of all vendor risk assessments
Risk trends analyzed across vendor portfolio
High-risk findings tracked to resolution
Risk acceptance decisions reviewed
Assessment methodology evaluated and updated

Vendor Risk Reporting

Risk Assessment Report
Individual vendor risk assessment report documenting: Assessment scope, methodology, scores, findings, risk treatment, approval
Report retained in vendor management records
Report shared with relevant stakeholders

Vendor Risk Dashboard
Aggregate vendor risk metrics tracked
Total vendors by risk tier
Average risk scores by tier and domain
Open risk findings and remediation status
Vendor risk trends over time

Quarterly Vendor Risk Summary
Summary of vendor risk posture provided to CISO quarterly
New vendor assessments completed
Reassessments completed
Risk findings and remediation status
Vendor incidents and their impact

Annual Vendor Risk Report
Comprehensive annual review of vendor risk program
Program effectiveness and maturity
Assessment coverage and completeness
Risk trends and emerging threats
Program improvements and recommendations

Roles and Responsibilities

CISO ([OWNER_NAME])
Overall responsibility for vendor risk assessment program
Approve vendor risk assessment methodology
Approve Critical and High Risk vendor assessments
Review vendor risk reports and metrics
Ensure vendor risk program aligns with organizational risk appetite

Department Managers
Identify vendor needs and initiate risk assessments
Participate in vendor risk assessment process
Implement vendor risk mitigation measures
Monitor vendor compliance with risk requirements
Escalate vendor risk issues to CISO

IT and Security Team
Conduct vendor security assessments
Review vendor security questionnaires and evidence
Score vendor risk across assessment domains
Monitor vendor security posture
Support vendor incident response

Procurement
Ensure vendor risk assessment completed before contract execution
Include risk-based security requirements in vendor contracts
Maintain vendor risk assessment records
Coordinate vendor risk assessment schedule

Legal Counsel
Review vendor contracts for risk-appropriate protections
Advise on regulatory compliance requirements
Support vendor risk treatment decisions
Manage vendor legal and compliance issues

Contact Information

For vendor risk assessment questions or to initiate a vendor risk assessment, contact:

[OWNER_NAME]
Founder and Chief Information Security Officer
[COMPANY_LEGAL_NAME]
Email: [CONTACT_EMAIL]
Phone: [CONTACT_PHONE]
[COMPANY_CITY], [GOVERNING_STATE]

UEI: [COMPANY_UEI]
CAGE Code: [COMPANY_CAGE_CODE]
