# 🚀 CSPM Integration Guide: Wiz & Microsoft Defender for Cloud

## 🌐 Overview

Cloud Security Posture Management (CSPM) integration enhances visibility and security management across multi-cloud environments. This guide provides detailed steps, visuals, tips, and a roadmap to successfully integrate AWS, Azure, GCP, and Oracle OCI/OIC into Wiz and Microsoft Defender for Cloud.

---

## 🔵 Integrating Cloud Platforms into Wiz

### ☁️ AWS Integration

**🛠️ Preparation Steps:**
- ✅ Create IAM Role with **SecurityAudit** permissions.
- ✅ Set up trust relationship with Wiz's AWS account.

**🔗 Integration Steps:**
- Navigate to `Wiz Console > Integrations > AWS`.
- Enter IAM Role ARN for resource discovery and validation.

⚠️ **Common Issues:**
- IAM misconfiguration, restrictive SCP policies.

---

### ☁️ Azure Integration

**🛠️ Preparation Steps:**
- ✅ Azure AD App registration & service principal.
- ✅ Assign appropriate roles (`Reader`, `Security Reader`).

**🔗 Integration Steps:**
- Navigate to `Wiz Console > Integrations > Azure`.
- Enter Tenant ID, Client ID, Client Secret.

⚠️ **Common Issues:**
- RBAC misconfiguration, Azure policies, conditional access restrictions.

---

### ☁️ GCP Integration

**🛠️ Preparation Steps:**
- ✅ Create service account with `Viewer` or `Security Reviewer` roles.
- ✅ Generate and securely store JSON key file.

**🔗 Integration Steps:**
- Navigate to `Wiz Console > Integrations > GCP`.
- Upload the JSON key file.

⚠️ **Common Issues:**
- Incorrect IAM roles, firewall or access control blocks.

---

### ☁️ Oracle OCI/OIC Integration

**🛠️ Preparation Steps:**
- ✅ OCI user setup with API keys (Security Audit permissions).
- ✅ Define IAM policies granting Wiz necessary read-only access.

**🔗 Integration Steps:**
- Navigate to `Wiz Console > Integrations > OCI`.
- Provide API fingerprint, user OCID, tenancy OCID, private key.

⚠️ **Common Issues:**
- IAM misconfiguration, restricted security rules.

---

## 🟢 Integrating Cloud Platforms into Microsoft Defender for Cloud CSPM

*Follow similar preparation and integration steps outlined above for AWS, Azure, GCP, and OCI/OIC using Azure Arc connectors or native integrations.*

---

## 📆 30-Day Security & Architecture Roadmap Post Integration

### 🗓️ Week 1: Initial Configuration & Validation
- 🔍 Validate successful integration and initial asset discovery.
- 🛡️ Enable baseline security policies and compliance frameworks.
- 📈 Review initial risk assessment and prioritize critical findings.

### 🗓️ Week 2: Policy Optimization & Remediation
- ✅ Optimize security policies based on initial findings.
- 🚩 Begin addressing high-risk vulnerabilities and compliance gaps.
- 📊 Set up regular reporting and alerting mechanisms.

### 🗓️ Week 3: Continuous Monitoring & Reporting
- 🔄 Establish continuous monitoring processes.
- 📋 Conduct weekly review meetings for identified security issues.
- 📑 Generate dashboards/reports for security posture visibility.

### 🗓️ Week 4: Advanced Security Practices
- 🛠️ Implement automated remediation actions.
- 📌 Conduct a comprehensive architecture and security review.
- 🚀 Plan future enhancements based on roadmap progress.

---

## 📊 Auditing, Reporting & Dashboard Guidance

### 📉 Wiz Dashboard
- **Recommended Dashboards:** Security Posture Overview, Vulnerabilities, Compliance Status.
- **Auditing:** Regular audits using built-in Wiz compliance reports.
- **Reports:** Schedule automatic reports (weekly/monthly) highlighting critical issues and compliance gaps.

### 📉 Microsoft Defender Dashboard
- **Recommended Dashboards:** Defender for Cloud overview, Compliance and Security Posture Reports.
- **Auditing:** Utilize Azure Sentinel and integrated Defender auditing logs.
- **Reports:** Configure automated reporting in Azure, focusing on security recommendations and compliance adherence.

---

## 📌 Best Practices for Successful CSPM Integration
- 🎯 Clearly define integration scope and objectives.
- 🔑 Accurately configure IAM roles and policies.
- 🌉 Deploy required connectors/agents effectively.
- 🔄 Regularly verify integrations and resource discovery health.

---

## 🚧 Potential Design & Implementation Roadblocks
- **🔒 IAM & Permissions:** Incorrect roles or insufficient access.
- **🧱 Network Constraints:** Firewall, ACL, and security rules.
- **📜 Compliance Policies:** Pre-existing security policies hindering setup.
- **⚙️ Operational Complexity:** Scale and automation challenges.
- **🌍 Compliance Considerations:** Data residency, privacy, and regulatory constraints.

---

🛡️ **Stay Secure. Stay Integrated.** 📌

