# Azure Security Baseline Checklist ✅

This checklist outlines fundamental security controls and configurations for Azure resources. Use it to verify that your environment is set up with secure defaults, proper encryption, and effective auditing. Review each item and mark it as complete once implemented.

---

## 1. Identity & Access Management

- [ ] **Azure Active Directory (AAD) Security**
  - Enforce **Multi-Factor Authentication (MFA)** for all users and administrators.
  - Use **Conditional Access Policies** to restrict access based on location, device, or risk.
  - Regularly review and minimize **Role-Based Access Control (RBAC)** assignments.
  - Implement **Azure AD Privileged Identity Management (PIM)** for managing elevated access.

- [ ] **Secure Application Identities**
  - Use **Managed Identities** for Azure resources instead of storing credentials in code.
  - Limit and monitor service principal permissions.

---

## 2. Networking & Perimeter Security

- [ ] **Virtual Network (VNet) Configuration**
  - Design networks following a **hub-and-spoke** model to isolate workloads.
  - Use **Network Security Groups (NSGs)** to restrict inbound/outbound traffic.
  - Enable **Azure Firewall** for centralized traffic filtering.
  - Implement **VPN Gateway** or **ExpressRoute** with proper segmentation for secure remote access.

- [ ] **VNet Peering & Microsegmentation**
  - Establish **VNet Peering** with proper restrictions to control lateral movement.
  - Use **Azure Private Link** to secure connectivity to PaaS services.

---

## 3. Data Protection & Encryption

- [ ] **Encryption at Rest & in Transit**
  - Ensure all data stored in Azure is encrypted using **Azure Storage encryption** (with managed or customer-managed keys).
  - Enable **TLS/SSL** for data in transit across all endpoints.
  - Apply encryption to databases, virtual machines, and backups.

- [ ] **Secure Secret Management**
  - Store secrets, keys, and certificates in **Azure Key Vault**.
  - Regularly rotate keys and monitor access logs.

---

## 4. Logging, Monitoring & Auditing

- [ ] **Centralized Logging & Monitoring**
  - Deploy a **Log Analytics Workspace** to consolidate logs from all Azure services.
  - Enable **Azure Monitor** to collect metrics and logs for continuous analysis.
  - Integrate with **Azure Sentinel** for advanced threat detection and automated response.

- [ ] **Auditing & Compliance**
  - Enable **Diagnostic Settings** on critical resources to capture audit logs.
  - Regularly review logs and alerts to ensure compliance with organizational policies.

---

## 5. Infrastructure & Resource Management

- [ ] **Secure Deployment Practices**
  - Use **Infrastructure as Code (IaC)** (e.g., Terraform) to standardize and automate deployments.
  - Apply **Azure Policy** to enforce security configurations and compliance across your environment.
  - Regularly update resources to ensure that patches and security updates are applied promptly.

- [ ] **Backup & Recovery**
  - Configure **Azure Backup** for critical data and ensure recovery procedures are tested.
  - Implement redundancy and disaster recovery planning.

---

## 6. Additional Best Practices

- [ ] **Regular Security Assessments**
  - Schedule periodic **vulnerability assessments** and **penetration tests**.
  - Review and update security baselines to adapt to new threats.
  
- [ ] **Documentation & Training**
  - Maintain up-to-date documentation of your security controls.
  - Train staff on security policies, threat awareness, and incident response.

---

*Tip: Use this checklist during internal audits to continuously verify that your Azure environment adheres to the best security practices and Zero Trust principles.*
