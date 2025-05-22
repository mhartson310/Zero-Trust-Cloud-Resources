# 🔐 Verifying Credentials Step-by-Step with Microsoft Entra Verified ID

Verifying verifiable credentials is the core function of a "Verifier" in the decentralized identity ecosystem. This process allows your application to cryptographically confirm the authenticity and validity of a credential presented by a holder, enhancing trust and security at the point of access or interaction.

This guide provides a step-by-step overview of how to build a verifier service to verify verifiable credentials using Microsoft Entra Verified ID.

## Prerequisites

* A configured [Microsoft Entra Verified ID tenant](setup-verified-id-tenant.md).
* An application (e.g., a web API or web application) that will act as your verifier service.
* An Azure App Registration with API permissions for Microsoft Entra Verified ID (`VerifiableCredentials.ReadWrite.All`).
* Basic understanding of JSON Web Tokens (JWTs) and REST APIs.

## The Verification Flow Overview

The verification flow typically involves these steps:

1.  **Your App (Verifier Service) initiates verification:** Your app makes an API call to the Microsoft Entra Verified ID service to request a credential presentation.
2.  **Verified ID Service generates QR code/link:** The service generates a unique URL (and often a QR code) that the holder will use to present the credential.
3.  **Holder scans QR code/clicks link:** The holder's digital wallet (e.g., Microsoft Authenticator) opens the link.
4.  **Holder selects and presents:** The holder reviews the presentation request, selects the requested credential(s) from their wallet, and consents to share.
5.  **Verified ID Service validates and notifies your app:** The service cryptographically validates the presented credential(s) and sends a callback to your app's designated endpoint, notifying it of the presentation status and the verified claims.

## Step-by-Step Implementation

### Step 1: Acquire an Access Token for API Calls

Your verifier service needs to authenticate to the Microsoft Entra Verified ID API, similar to the issuer. This is typically done using an OAuth 2.0 client credentials flow.

1.  **Configure App Registration:** Ensure your Azure AD App Registration has the `VerifiableCredentials.ReadWrite.All` API permission granted.
2.  **Get Client ID & Client Secret:** Note the `client_id` and `client_secret` (or certificate) of your App Registration.
3.  **Request Token:** Your service will make a POST request to the Microsoft Identity Platform's token endpoint:

    ```http
    POST https://login.microsoftonline.com/<your-tenant-id>/oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded

    client_id=<your-app-registration-client-id>
    &scope=3a1b0210-c1ca-433b-af0e-3c87e92394c2/.default # Scope for Verified ID API
    &client_secret=<your-app-registration-client-secret>
    &grant_type=client_credentials
    ```

    You'll receive an `access_token` in the response.

### Step 2: Create a Presentation Request

Your verifier service makes a POST request to the Microsoft Entra Verified ID Presentation API. This request specifies what type of credential you want to verify and where to send the callback.

```http
POST https://beta.did.msidentity.com/v1.0/<your-tenant-id>/verifiablecredentials/request
Authorization: Bearer <your-access-token>
Content-Type: application/json

{
  "includeQRCode": true,
  "callback": {
    "url": "https://your-verifier-service.com/api/verifiedid/presentation-callback",
    "state": "your-unique-state-for-this-presentation", // Unique ID for tracking
    "headers": {
      "api-key": "your-callback-api-key" // Optional: For securing your callback endpoint
    }
  },
  "authority": "did:web:your-verified-id-domain.com", // Your verifier DID
  "registration": {
    "clientName": "Your Service Name"
  },
  "requestedCredentials": [
    {
      "type": "vc.yourcompany.com/employeecredential", // The 'id' of the credential type you expect
      "purpose": "To verify your employment status with Your Company."
    }
  ]
}
```

---

## ❓ Frequently Asked Questions (FAQ) for Verifying Credentials Step-by-Step with Microsoft Entra Verified ID

Here are some common questions you might have when building a verifier service for Microsoft Entra Verified ID.

### 1. What's the difference between a `request_approved` callback and actually trusting the claims? 🤔

* **Answer:** A `request_approved` callback from the Microsoft Entra Verified ID service means that the **service has successfully validated the cryptographic integrity** of the presented verifiable credential(s) and confirmed it hasn't been tampered with. It also means the holder presented what you asked for. However, your application still needs to **decide if it *trusts* the *claims* and the *issuer***. You should implement business logic to check:
    * If the issuer's DID is on your list of trusted issuers. 🤝
    * If the claims meet your requirements (e.g., `employeeId` matches your internal records, `degree` is from a recognized institution).
    * If the credential has been revoked. 💔

### 2. How does my verifier service know if an issuer is trustworthy? 🤝

* **Answer:** Your verifier service implicitly trusts the cryptographic validation performed by the Microsoft Entra Verified ID service. However, for real-world scenarios, your application should maintain an **explicit list of trusted issuer DIDs**. When a credential is presented, you compare the issuer's DID from the `verifiedCredentials` payload against your predefined list. If the issuer's DID is not trusted, your application should reject the verification, even if the credential is cryptographically valid.

### 3. What happens if a presented credential has been revoked? 💔

* **Answer:** The Microsoft Entra Verified ID service automatically performs a **revocation check** when a credential is presented. If the credential has been revoked by the issuer, the `requestStatus` in the callback you receive will indicate a failure (e.g., `request_declined` or an error status). The `verifiedCredentials` array will typically be empty or indicate the revocation reason. Your application should always check the `requestStatus` and act accordingly.

### 4. Can my verifier service verify credentials issued by different organizations or different credential types? 🌍

* **Answer:** Yes, absolutely! Microsoft Entra Verified ID is designed to be interoperable. Your verifier service can:
    * Request specific `type`s of credentials, allowing users to present credentials from various issuers.
    * Verify credentials from **any issuer** whose DID is publicly resolvable (e.g., `did:web` or `did:ion`).
    * Your trust decision (Question 2) will then determine if you *accept* credentials from a given issuer.

### 5. How does the verifier know that the person presenting the credential is the actual holder? 🤳

* **Answer:** This is a crucial aspect known as **Proof of Possession (PoP)** or **Holder Binding**. When a holder presents a credential from their digital wallet, the wallet cryptographically signs the presentation using the holder's private key (linked to their DID). The Microsoft Entra Verified ID service validates this signature. This cryptographic proof ensures that the person presenting the credential is indeed the legitimate holder of the associated DID and wallet. Your application receives this assurance via the `request_approved` status from the service.

### 6. What if a user presents a credential that my verifier didn't specifically ask for? 🤔

* **Answer:** The Microsoft Entra Verified ID service primarily facilitates the presentation of credentials that match your `requestedCredentials` criteria. If a user tries to present a credential that doesn't match the `type` you requested, the service will likely prevent it from being presented, or it will simply not include it in the `verifiedCredentials` array of the successful callback. Your verifier should **only rely on the claims present in the `verifiedCredentials` array** and ensure they match your expected credential types.

### 7. What kind of application can act as a verifier? 📱💻

* **Answer:** Almost any type of application can be a verifier! This includes:
    * **Web applications:** A login page, a registration form, or an internal portal.
    * **Mobile applications:** For user onboarding or in-app identity verification.
    * **Backend APIs:** For granting access to resources or processing sensitive transactions based on verified attributes.
    * **Kiosk/Physical Access Systems:** Though requiring integration with hardware for QR code scanning.
    The core is that your application needs to be able to initiate HTTP requests to the Microsoft Entra Verified ID Presentation API and receive callbacks at a publicly accessible endpoint.
