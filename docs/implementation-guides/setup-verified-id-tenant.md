# 🛠️ Setting Up Your Microsoft Entra Verified ID Tenant

Before you can start issuing or verifying verifiable credentials, you need to enable and configure the Microsoft Entra Verified ID service within your Azure tenant. This involves provisioning the necessary resources and configuring the service for your organization.

This guide provides a step-by-step walkthrough to set up your Microsoft Entra Verified ID tenant in the Azure portal.

## Prerequisites

* An Azure subscription.
* A Microsoft Entra ID tenant.
* A user with **Global Administrator** or **Verified ID Administrator** role in your Microsoft Entra ID tenant.

## Step-by-Step Setup

### 1. 🌐 Navigate to Microsoft Entra Verified ID

1.  Sign in to the [Azure portal](https://portal.azure.com/) with an account that has the required administrative roles.
2.  In the search bar at the top, type "Microsoft Entra Verified ID" and select it from the services list.
    * Alternatively, navigate to **Microsoft Entra ID** (formerly Azure Active Directory) > **Verified ID** (under the "Manage" section).

### 2. 🚀 Get Started with Verified ID

1.  On the Verified ID overview page, you'll see a "Get started" or "Quick start" section. Click on the **Get started** button.

### 3. 📄 Select Your Organization

1.  You will be prompted to select the organization (your Microsoft Entra ID tenant) for which you want to set up Verified ID. Ensure the correct tenant is selected.

### 4. 🔗 Register Your Decentralized Identifier (DID)

This is a crucial step where your organization's unique Decentralized Identifier (DID) is created and registered. This DID is how others (holders and verifiers) will cryptographically identify your organization as a trusted issuer or verifier.

1.  On the "Register decentralized ID" step, you'll need to choose your DID method. The recommended method is **`did:web`**.
    * **Why `did:web`?** `did:web` maps your organization's DID to a friendly web domain you own (e.g., `https://verifiedid.yourcompany.com`). This makes your DID discoverable and verifiable via standard web infrastructure.
2.  **Provide your domain:** Enter the domain name you want to associate with your DID (e.g., `verifiedid.yourcompany.com`).
    * **Important:** You must have control over this domain and be able to host a file at a specific path on it later.
3.  Click **Register**.

### 5. 🔑 Configure Key Vault (if not already configured)

Microsoft Entra Verified ID uses Azure Key Vault to securely store the cryptographic keys associated with your organization's DID.

1.  If you don't have a Key Vault configured, the setup wizard will guide you to create one.
2.  **Select a Subscription and Resource Group:** Choose the Azure subscription and a resource group where the Key Vault will reside.
3.  **Name the Key Vault:** Provide a unique name for your Key Vault.
4.  **Grant Permissions:** The wizard will automatically configure access policies for the Verified ID service principal to access the Key Vault. Ensure these permissions are granted.
5.  Click **Review + create** and then **Create**.

### 6. 🌐 Publish Your `did:web` DID Document

After the DID is registered and Key Vault is set up, you'll be given instructions to publish your `did:web` DID Document. This involves hosting a specific file (`did.json`) at a particular path on your chosen web domain.

1.  The Azure portal will display the exact **`did.json`** file content you need to create.
2.  It will also specify the exact **URL path** where this file must be hosted (e.g., `https://verifiedid.yourcompany.com/.well-known/did.json`).
3.  **Host the file:**
    * You'll need a web server or Azure Storage Static Website/Azure App Service configured to serve this file at the specified URL.
    * Ensure the file is publicly accessible and can be retrieved via HTTPS.
4.  Once the file is hosted, click **Refresh registration status** in the Azure portal.
5.  The status should change to "Completed" or "Verified".

### 7. 🎉 Setup Complete!

Once all steps are marked as complete, your Microsoft Entra Verified ID tenant is successfully configured. You will now see an overview page showing your organization's DID, associated domain, and Key Vault.

## Next Steps

With your tenant set up, you are ready to:

* **Design your Verifiable Credentials:** Define the types of credentials you want to issue.
* **Build an Issuer Service:** Create an application that calls the Verified ID APIs to issue credentials.
* **Build a Verifier Service:** Create an application that calls the Verified ID APIs to verify credentials.

This initial setup provides the foundation for all your verifiable credential activities!

---

## ❓ Frequently Asked Questions (FAQ) for Setting Up Your Microsoft Entra Verified ID Tenant

Here are some common questions you might have when setting up Microsoft Entra Verified ID in your Azure tenant.

### 1. What Azure roles do I need to set up Microsoft Entra Verified ID?

* **Answer:** You need a user account with either the **Global Administrator** 🌐 or the **Verified ID Administrator** 🛡️ role in your Microsoft Entra ID tenant. These roles have the necessary permissions to provision the Verified ID service and configure its prerequisites like Azure Key Vault.

### 2. Why do I need an Azure Key Vault for Microsoft Entra Verified ID? 🔑

* **Answer:** Azure Key Vault is essential for securely storing the cryptographic keys associated with your organization's Decentralized Identifier (DID). These keys are fundamental to the security of your verifiable credentials, as they are used to cryptographically sign the credentials you issue and verify presentations. Key Vault provides a highly secure and managed environment for these sensitive keys.

### 3. What is `did:web` and why is it the recommended DID method? 🌐

* **Answer:** `did:web` is a Decentralized Identifier (DID) method that links your organization's DID to a friendly web domain you own (e.g., `verifiedid.yourcompany.com`). It's recommended because it makes your organization's DID easily discoverable and verifiable by standard web infrastructure (HTTPS). This leverages existing trust in domain names, making it simpler for verifiers to establish trust in your organization as an issuer.

### 4. What if I don't own a custom domain or can't host the `did.json` file? 🤔

* **Answer:** While `did:web` is recommended, if you cannot use a custom domain, the setup wizard might offer `did:ion` as an alternative. `did:ion` registers your DID on the ION network (a layer 2 decentralized identity network built on Bitcoin). However, `did:web` is generally simpler for initial setup and public discoverability for most organizations. You will still need a way to host the `did.json` file on a web server or Azure Storage Static Website at the specified path for `did:web` to work.

### 5. How exactly do I host the `did.json` file? Where should it go? 📂

* **Answer:** After you register your `did:web` DID, the Azure portal will provide the exact JSON content for the `did.json` file and the specific URL path where it must be hosted. You need to host this file on a web server or an Azure service like Azure Storage Static Website ☁️ or Azure App Service. The file must be publicly accessible via HTTPS at the exact path provided (e.g., `https://your-verified-id-domain.com/.well-known/did.json`). **It's crucial that the path and content are exact!**

### 6. What happens if I lose access to the Azure Key Vault that stores my Verified ID keys? 🚨

* **Answer:** Losing access to your Key Vault, or the keys within it, would severely impact your ability to issue and verify verifiable credentials. Your organization's DID relies on these keys for cryptographic operations. Microsoft Entra Verified ID does **not** store your keys. Therefore, it's critical to implement robust Key Vault access policies, backups, and recovery strategies (e.g., soft-delete and purge protection) as per Azure Key Vault best practices. Without access to these keys, your existing DID becomes unusable.

### 7. How long does the tenant setup process usually take? What are common delays? ⏱️

* **Answer:** The initial setup steps within the Azure portal (registering DID, configuring Key Vault) are usually very quick, often just a few minutes. The main potential delay comes from **publishing the `did.json` file on your custom domain**. This step depends on your organization's IT processes for web hosting. Common delays include:
    * Getting a web server or storage account configured.
    * DNS propagation if you're setting up a new subdomain.
    * Firewall rules blocking access to the `.well-known` path.
    * Ensuring the `did.json` file is served with the correct `Content-Type: application/json`.
    * **Tip:** Verify public accessibility of the `did.json` file in a browser or with `curl` before clicking "Refresh registration status" in the portal.
