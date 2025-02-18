# Compliance Checklists for Specific Regulations & Standards

This document provides tailored checklists for various regulatory and security standards in Azure. Each checklist includes specific controls and actionable remediation steps designed to align with Zero Trust principles. Use these checklists during audits and remediation efforts to ensure your cloud environment meets the required standards.

---

## GDPR Compliance Checklist (General Data Protection Regulation) 🇪🇺

- [ ] **📂 Data Inventory & Classification:**  
  Identify and classify all personal data stored or processed in your Azure environment.
- [ ] **✂️ Data Minimization:**  
  Collect and retain only the personal data necessary for your operations.
- [ ] **📝 Consent Management:**  
  Implement processes to obtain, record, and manage user consent.
- [ ] **🔒 Encryption:**  
  Encrypt personal data at rest (using Azure Storage encryption with managed or customer-managed keys) and in transit (using TLS/SSL).
- [ ] **👥 Access Controls:**  
  Enforce RBAC and MFA to restrict access to personal data.
- [ ] **🛡️ Data Subject Rights:**  
  Enable processes for data subjects to access, rectify, or delete their data.
- [ ] **⏰ Data Breach Notification:**  
  Establish procedures to notify regulators and affected individuals within 72 hours of a breach.
- [ ] **🤝 Data Processing Agreements:**  
  Ensure third-party processors sign contracts that meet GDPR standards.
- [ ] **🔄 Regular Audits:**  
  Conduct periodic audits to verify ongoing GDPR compliance.

---

## HIPAA Compliance Checklist (Health Insurance Portability and Accountability Act) 🏥

- [ ] **🛠️ Risk Analysis:**  
  Regularly perform risk assessments on systems handling Protected Health Information (PHI).
- [ ] **🔐 Access Controls:**  
  Limit access to PHI using RBAC, MFA, and strict permission policies.
- [ ] **📝 Audit Controls:**  
  Enable comprehensive logging and monitoring of all access to PHI.
- [ ] **🔒 Encryption:**  
  Encrypt PHI both at rest and in transit.
- [ ] **🤝 Business Associate Agreements (BAA):**  
  Ensure all vendors with access to PHI sign appropriate BAAs.
- [ ] **📚 Security Training:**  
  Provide regular HIPAA training for all staff handling PHI.
- [ ] **📋 Contingency Planning:**  
  Develop, document, and test backup and disaster recovery plans for PHI.
- [ ] **🚪 Physical Safeguards:**  
  Secure physical access to data centers and devices storing PHI.

---

## PCI-DSS Compliance Checklist (Payment Card Industry Data Security Standard) 💳

- [ ] **🔐 Network Security:**  
  Deploy firewalls and NSGs to protect cardholder data in transit and at rest.
- [ ] **🤝 Vendor Management:**  
  Ensure that all third-party providers comply with PCI-DSS requirements.
- [ ] **🔒 Data Encryption:**  
  Encrypt cardholder data during storage and transmission.
- [ ] **👤 Access Controls:**  
  Assign unique IDs, enforce strong authentication, and limit privileges.
- [ ] **🛡️ Regular Monitoring:**  
  Log and monitor all access to cardholder data.
- [ ] **🛠️ Vulnerability Management:**  
  Regularly update, patch, and scan systems for vulnerabilities.
- [ ] **🔍 Penetration Testing:**  
  Perform periodic penetration tests to identify and remediate vulnerabilities.
- [ ] **📃 Security Policies:**  
  Maintain and enforce a comprehensive security policy for all employees.

---

## SOC 2 Compliance Checklist (System and Organization Controls) 🔒

- [ ] **🛡️ Security Controls:**  
  Implement robust controls to protect system resources and sensitive data.
- [ ] **📈 Availability:**  
  Ensure system uptime and have effective backup and disaster recovery plans in place.
- [ ] **⏱️ Processing Integrity:**  
  Ensure that data processing is accurate, complete, and timely.
- [ ] **🔒 Confidentiality:**  
  Protect confidential information with encryption and strict access controls.
- [ ] **👤 Privacy:**  
  Adhere to privacy policies governing the collection and use of personal data.
- [ ] **📝 Audit Logging:**  
  Maintain detailed logs for all critical operations and data access.
- [ ] **🔄 Regular Assessments:**  
  Conduct periodic internal audits and assessments to verify SOC 2 controls.

---

## CSA Compliance Checklist (Cloud Security Alliance – Cloud Controls Matrix) ☁️

- [ ] **📊 Governance & Risk Management:**  
  Implement governance frameworks and risk management processes aligned with CSA CCM.
- [ ] **📂 Data Security & Information Lifecycle Management:**  
  Encrypt data at rest and in transit; enforce data classification and secure disposal practices.
- [ ] **👤 Identity & Access Management:**  
  Enforce strong authentication (MFA), least privilege, and centralized identity management.
- [ ] **🛠️ Infrastructure & Virtualization Security:**  
  Harden cloud configurations, conduct regular vulnerability assessments, and apply secure baseline settings.
- [ ] **🚨 Incident Management:**  
  Establish a robust incident response process with automated alerts and post-incident analysis.
- [ ] **🤝 Third-Party Risk Management:**  
  Ensure that vendors and cloud service providers meet CSA controls and certifications.

---

## CIS Controls Checklist (Center for Internet Security) 🛡️

- [ ] **🖥️ Inventory of Authorized Devices:**  
  Maintain an up-to-date inventory of all hardware assets connected to your cloud environment.
- [ ] **💻 Inventory of Authorized Software:**  
  Track and manage all software assets in use.
- [ ] **🛠️ Secure Configurations:**  
  Apply secure baseline configurations to hardware and software assets.
- [ ] **🔍 Continuous Vulnerability Management:**  
  Regularly scan for vulnerabilities and remediate them promptly.
- [ ] **🔑 Controlled Use of Administrative Privileges:**  
  Enforce least privilege and use MFA for privileged accounts.
- [ ] **📜 Audit Log Management:**  
  Enable, store, and review audit logs for all critical systems.
- [ ] **📧 Email and Web Browser Protections:**  
  Deploy robust security controls on endpoints, including anti-phishing measures.
- [ ] **🦠 Malware Defenses:**  
  Use anti-malware tools and keep them up to date.
- [ ] **💾 Data Recovery Capability:**  
  Regularly back up critical data and test restore procedures.
- [ ] **📚 Security Awareness Training:**  
  Conduct regular training sessions on cybersecurity best practices.
- [ ] **🚨 Incident Response & Management:**  
  Develop, test, and refine an incident response plan.

---

## NIST SP 800-53 Compliance Checklist (National Institute of Standards and Technology) 🇺🇸

- [ ] **🔐 Access Control (AC):**  
  Enforce strict access controls through RBAC and least privilege.
- [ ] **📚 Awareness and Training (AT):**  
  Provide comprehensive security training for all employees.
- [ ] **📝 Audit and Accountability (AU):**  
  Maintain and review audit logs, ensuring continuous monitoring.
- [ ] **🛠️ Security Assessment & Authorization (CA):**  
  Regularly assess system security and authorize changes.
- [ ] **🔧 Configuration Management (CM):**  
  Control and monitor configuration changes to systems.
- [ ] **📋 Contingency Planning (CP):**  
  Develop and test disaster recovery and business continuity plans.
- [ ] **🆔 Identification and Authentication (IA):**  
  Ensure robust identity verification for all users and devices.
- [ ] **🚨 Incident Response (IR):**  
  Establish and maintain a comprehensive incident response plan.
- [ ] **🛠️ Maintenance (MA):**  
  Regularly perform system maintenance and updates.
- [ ] **💽 Media Protection (MP):**  
  Protect data stored on physical and digital media.
- [ ] **🏢 Physical and Environmental Protection (PE):**  
  Secure physical access to critical infrastructure.
- [ ] **📊 Risk Assessment (RA):**  
  Conduct periodic risk assessments to identify and mitigate threats.
- [ ] **🔄 System and Information Integrity (SI):**  
  Monitor system integrity and apply patches promptly.
- [ ] **📋 Program Management (PM):**  
  Oversee a comprehensive, organization-wide security program.

---

*Tip: Adapt these checklists to your organization's specific needs and environment. Regularly review and update each section to reflect evolving regulatory requirements and security best practices.*
