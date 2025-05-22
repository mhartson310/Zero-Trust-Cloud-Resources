# 🔄 Credential Revocation and Recovery in Verified ID

In a decentralized identity system, while holders control their credentials, issuers retain the critical ability to **revoke** credentials. This is essential for managing risk when the underlying attestation of a credential (e.g., employment status, certification validity) changes or when a credential is compromised. Additionally, having a clear **recovery** strategy for lost or compromised digital wallets is crucial for user experience and continuity.

This guide explores the mechanisms for credential revocation and strategies for wallet recovery in the context of Microsoft Entra Verified ID.

## 💔 Credential Revocation

Credential revocation is the process by which an **issuer** invalidates a previously issued verifiable credential. Once revoked, a credential should no longer be considered valid by **verifiers**.

### Reasons for Revocation:

* **Change in Status:** An employee leaves the company, a student graduates, a license expires, or a certification is no longer valid.
* **Credential Compromise:** The holder's digital wallet or the credential itself is suspected to be compromised.
* **Fraudulent Issuance:** The credential was issued based on false information or a fraudulent identity proofing process.
* **Holder Request:** The holder explicitly requests the credential to be revoked.

### Microsoft Entra Verified ID Revocation Mechanism:

Microsoft Entra Verified ID leverages the Decentralized Identifiers (DID) system for revocation. When an issuer wishes to revoke a credential:

1.  **Revocation List Update:** The issuer adds the unique identifier (e.g., `id` of the credential) to a **revocation list**. This list is essentially a digitally signed set of revoked credential IDs.
2.  **DID Document Update:** The issuer's Decentralized Identifier (DID) Document is updated to include a reference (e.g., a URL) to this revocation list. This update is anchored to the decentralized ledger (e.g., ION network).
3.  **Verifier Check:** When a verifier receives a verifiable presentation, they will:
    * Resolve the issuer's DID to retrieve its DID Document.
    * Discover the link to the issuer's revocation list within the DID Document.
    * Query the revocation list to check if the presented credential's ID is present. If it is, the credential is considered invalid.

### Best Practices for Revocation:

* **Automate Revocation:** Integrate revocation triggers into your identity lifecycle management (ILM) systems (e.g., when an employee is deprovisioned in your HR system).
* **Clear Policies:** Define clear policies for when and how credentials will be revoked.
* **Communicate with Holders:** Inform holders when their credentials are about to be or have been revoked.
* **Monitor Revocation Status:** Verifiers should actively check revocation status during every verification process.

## ♻️ Wallet and Identity Recovery

A user's digital wallet holds their verifiable credentials, which are intrinsically linked to their Decentralized Identifiers (DIDs). Losing access to this wallet or its private keys can lead to a loss of access to all credentials and associated identities. A robust recovery strategy is vital.

### Challenges of Recovery in Decentralized Identity:

* **No Central Reset:** Unlike traditional systems, there's no central "forgot password" button for a DID's private keys.
* **Holder Control:** The power of self-sovereign identity means the holder is solely responsible for their keys.

### Microsoft Entra Verified ID Recovery Considerations:

Microsoft Entra Verified ID primarily relies on the recovery mechanisms provided by the underlying DID method and the digital wallet application.

* **DID Method Recovery:**
    * **ION (Decentralized Identity Overlay Network):** The ION DID method supports a recovery key mechanism. If a user loses their primary private key, they can use a pre-configured recovery key to update their DID Document and replace the primary key, thereby regaining control of their DID.
    * **`did:web`:** For `did:web` DIDs, recovery typically involves having control over the web domain where the DID Document is hosted. If access to the domain is lost, the DID might become unrecoverable.
* **Wallet Application Recovery:**
    * **Backup Seed Phrases/Recovery Codes:** Many digital wallets provide a "seed phrase" (a sequence of words) or recovery codes during setup. Users *must* securely store these, as they are the master key to restore their wallet and DIDs on a new device.
    * **Cloud Backup:** Some wallet apps may offer encrypted cloud backups, but this introduces a dependency on a centralized service.

### Strategies for Enabling Recovery for Holders:

As an **issuer** or **verifier**, you can't directly recover a user's wallet, but you can facilitate recovery by:

* **Educating Users:** Provide clear instructions to users on how to back up their wallet's seed phrase/recovery codes during onboarding. Emphasize the importance of secure storage.
* **Re-issuance Policy:** Have a clear policy for re-issuing credentials to users who have lost access to their wallet but can re-prove their identity. This shifts the burden from wallet recovery to identity re-proofing.
* **Customer Support:** Offer support channels for users who experience issues, guiding them through wallet recovery steps or credential re-issuance.

## Holistic Approach

Managing revocation and recovery requires a holistic approach that considers:

* **Technical Implementation:** Utilizing the features of the DID method and wallet.
* **Policy and Procedures:** Defining clear rules and workflows for all stakeholders.
* **User Education:** Empowering users with the knowledge to protect their digital identities.

By proactively planning for these scenarios, you can build a more resilient and user-friendly verifiable credential ecosystem.
