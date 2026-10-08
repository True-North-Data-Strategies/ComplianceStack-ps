---
Doc-ID: POL-23
Doc-Name: AI GOVERNANCE POLICY
Category: policies
Source-Skill: internal-compliance
Evidence-Required:
  - ai_usage_logs
Status: template
---

[COMPANY_LEGAL_NAME]
AI GOVERNANCE POLICY

Purpose

This AI Governance Policy establishes [COMPANY_LEGAL_NAME]'s requirements for the responsible development, deployment, use, and oversight of artificial intelligence and machine learning systems across all business operations. This policy ensures AI systems are used ethically, securely, transparently, and in compliance with applicable regulations and client requirements.

Scope

This policy applies to all [COMPANY_NAME] use of AI and ML systems including but not limited to: large language models, generative AI tools, machine learning models, automated decision-making systems, AI-powered analytics, chatbots, and AI-assisted code generation. It applies to all personnel, contractors, and third parties using AI systems on behalf of the organization.

Governance and Cross-Package References

This policy is the authoritative source for organization-wide AI governance. Platform-specific AI controls are implemented through cloud-platform-security skill policies.

Universal [COMPANY_ABBREVIATION] Principles - AI Application:
Data-as-Regulated: All data used for AI training, inference, prompts, or processing treated as regulated by default unless explicitly classified otherwise
No Sensitive Data in Logs: AI prompts, responses, debugging output, training logs, fine-tuning data, and monitoring must NOT contain PII, PHI, PCI, CUI, or other regulated identifiers unless explicitly approved and logged

Cross-Package Integration:
security-governance skill (Security & Compliance Handbook): Master AI/ML governance framework establishing AI security principles
cloud-platform-security skill (AI Platform Governance): Platform-specific AI controls for cloud AI services
internal-compliance skill (Acceptable Use Policy): AI/ML acceptable use requirements and approved platforms
data-handling-privacy skill (Data Handling Standard): Data classification and handling requirements for AI/ML data
data-handling-privacy skill (Anonymization Standard): Techniques for anonymizing AI training data, prompts, and outputs
internal-compliance skill (Audit Logging and Monitoring Policy): Logging requirements for AI system usage

For platform-specific AI governance, see cloud-platform-security skill (AI Platform Governance).
For AI acceptable use requirements, see internal-compliance skill (Acceptable Use Policy - AI/ML section).
For data anonymization techniques, see data-handling-privacy skill (Anonymization Standard).

AI Governance Principles

Accountability and Oversight
AI systems subject to human oversight and accountability
AI decisions reviewable by qualified personnel
AI system owners identified and responsible for system behavior
AI governance reviewed and updated as technology evolves

Transparency and Explainability
AI system capabilities and limitations documented and communicated
AI-generated content identified as such when shared externally
AI decision-making logic documented to the extent technically feasible
Clients informed when AI is used in service delivery

Fairness and Non-Discrimination
AI systems designed and monitored to avoid bias and discrimination
AI training data reviewed for representational bias
AI outputs monitored for discriminatory patterns
Bias identified and corrected promptly

Privacy and Data Protection
AI systems comply with all applicable privacy regulations (GDPR, CCPA, HIPAA)
AI systems implement data minimization principles
AI training data anonymized per data-handling-privacy skill requirements
AI systems do not retain personal data beyond operational necessity

Safety and Security
AI systems tested for safety, robustness, and adversarial resilience
AI systems protected from prompt injection, data poisoning, and model extraction
AI system access controlled per least privilege principles
AI system vulnerabilities assessed and remediated

Approved AI Platforms and Tools

Platform Approval Process
AI platforms and tools must be approved before use
Approval based on security assessment, data handling practices, and compliance posture
Approved platforms documented in AI Platform Register
Unapproved AI platforms and tools prohibited for business use

Approved Platform Categories
Enterprise AI platforms approved by CISO (e.g., Google Vertex AI, Anthropic Claude API with enterprise agreement)
Internal AI tools built and deployed on approved infrastructure
AI-assisted development tools approved for code generation (with code review requirements)
AI analytics tools integrated with approved data pipelines

Prohibited Uses
Sending unredacted PII, PHI, PCI, CUI, or FTI to any external AI system without explicit client approval and anonymization
Using AI to make automated decisions with legal or significant effects on individuals without human review
Using AI to generate content that impersonates real individuals
Using consumer-tier AI tools (free chatbots, unvetted browser extensions) for any business or client data
Using AI to circumvent security controls, access restrictions, or compliance requirements
Training or fine-tuning external AI models on client data without written client approval

AI Data Governance

Data Input Controls
Data classified per data-handling-privacy skill (Data Handling Standard) before AI processing
Restricted and Confidential data requires explicit approval and anonymization before AI input
Internal data may be processed by approved enterprise AI platforms with appropriate controls
Public data may be processed by approved AI platforms without additional restrictions
All AI data inputs logged per internal-compliance skill (Audit Logging and Monitoring Policy)

Data Output Controls
AI outputs reviewed for accuracy before use in client deliverables
AI outputs reviewed for inadvertent disclosure of sensitive information
AI-generated code reviewed by qualified developer before deployment
AI-generated content reviewed by subject matter expert before external distribution
AI outputs containing errors corrected before use

Model and Training Data Governance
AI models used for business purposes registered in AI System Register
Model training data sources documented and approved
Training data anonymized per data-handling-privacy skill requirements
Model performance monitored and documented
Model retraining or fine-tuning requires CISO approval when using client data

Prompt Engineering Standards
Prompts designed to avoid eliciting sensitive data from AI models
System prompts documented and version-controlled
Prompt templates reviewed for security before deployment
Prompt injection defenses implemented for client-facing AI applications

AI Risk Assessment

Risk Assessment Process
AI systems assessed for risk before deployment
Risk assessment considers: Data sensitivity, decision impact, regulatory requirements, bias potential, security exposure
Risk level determines governance requirements and oversight
Risk assessment documented and approved by CISO for High and Critical risk systems

AI Risk Categories
Critical Risk: AI systems making or influencing decisions with legal, financial, or safety implications; AI processing Restricted data
High Risk: AI systems used in client service delivery; AI processing Confidential data
Medium Risk: AI systems used for internal productivity; AI processing Internal data
Low Risk: AI systems used for non-sensitive tasks; AI processing Public data only

Risk Mitigation
Critical and High Risk AI systems require: Human-in-the-loop review, bias testing, security assessment, client notification, enhanced logging
Medium Risk AI systems require: Output review process, standard logging, periodic assessment
Low Risk AI systems require: Standard acceptable use compliance, basic logging

AI Incident Management

AI-Specific Incidents
AI system producing harmful, biased, or discriminatory outputs
AI system leaking sensitive data through outputs or logs
AI system being manipulated through prompt injection or adversarial inputs
AI system making incorrect decisions with material impact
Unauthorized use of AI with business or client data

Incident Response
AI incidents reported per internal-compliance skill (Incident Response Plan)
AI-specific incidents escalated to CISO immediately
Affected AI system isolated or suspended pending investigation
Root cause analysis conducted
Corrective actions implemented before system restoration
Clients notified if their data or services affected

AI Compliance Requirements

Regulatory Compliance
AI systems comply with applicable regulations including GDPR (automated decision-making provisions, right to explanation), CCPA (profiling and automated decision-making), HIPAA (when processing PHI), NIST AI Risk Management Framework alignment, Executive Orders and guidance on AI from federal agencies
Compliance requirements assessed per AI risk level
Compliance documented and monitored

Government Contract Requirements
AI used in government contract delivery complies with contract-specific AI requirements
Federal AI transparency and accountability requirements implemented
AI bias testing conducted for government-facing systems
AI documentation maintained for government audit purposes
See government-contracting skill for federal AI requirements

Client Disclosure Requirements
Clients informed when AI is used in service delivery
AI capabilities and limitations disclosed to clients
Client approval obtained for AI processing of their data when required by contract or regulation
AI use documented in project records

AI Governance Roles and Responsibilities

CISO ([OWNER_NAME])
Overall responsibility for AI governance program
Approve AI platform and tool usage
Approve Critical and High Risk AI system deployments
Review AI risk assessments and incident reports
Ensure AI compliance with regulations and client requirements
Update AI governance policy as technology and regulations evolve

AI System Owners
Responsible for specific AI system compliance with this policy
Document AI system purpose, capabilities, and limitations
Conduct and maintain AI risk assessments
Monitor AI system performance and outputs
Report AI incidents and issues

All Personnel
Comply with AI acceptable use requirements
Use only approved AI platforms and tools
Do not input sensitive data into AI systems without authorization
Report AI incidents and concerns
Complete AI governance training

Monitoring and Audit

AI Usage Monitoring
AI system usage logged and monitored
AI data inputs and outputs monitored for policy compliance
Unauthorized AI usage detected and addressed
Monitoring results reviewed by CISO quarterly

AI Governance Audit
AI governance program audited annually
Audit assesses policy compliance, risk management, and controls
Audit findings documented and remediated
Audit results reported to management

AI System Register
Centralized register of approved AI systems maintained
Register includes: System name, owner, risk level, data types processed, approval date, review date
Register reviewed and updated quarterly
Register accessible to authorized personnel

Contact Information

For AI governance questions or to request AI platform approval, contact:

[OWNER_NAME]
Founder and Chief Information Security Officer
[COMPANY_LEGAL_NAME]
Email: [CONTACT_EMAIL]
Phone: [CONTACT_PHONE]
[COMPANY_CITY], [GOVERNING_STATE]

UEI: [COMPANY_UEI]
CAGE Code: [COMPANY_CAGE_CODE]
