# Quicksilver Studio → SideStore

## Goal

Both the Studio host application and every iOS-targeted project it generates must install cleanly via SideStore with zero Mac required after SideStore itself is set up.

## Studio Host App

Follow the same proven path used by QuicksilverV1:

1. GitHub Actions workflow `Archive IPA` produces an **unsigned** IPA (`Payload/QuicksilverStudio.app`).
2. Download the artifact on-device.
3. Install in SideStore (LocalDevVPN connected).
4. SideStore re-signs with the user’s Apple ID.

Optional signed path is available when the standard certificate secrets are present in the repository.

Bundle ID recommendation: `com.quicksilver.studio`  
Display name: Quicksilver Studio

## Generated iOS Projects

When a user creates or opens a Native iOS project inside Studio:

- Templates must include correct `PrivacyInfo.xcprivacy`, Info.plist, and entitlements stubs.
- “Export for SideStore” action must:
  1. Run the equivalent of an unsigned archive
  2. Package a proper IPA
  3. Surface the file for download / share sheet / Files app
- Generated projects should also ship a ready-to-use GitHub Actions workflow that produces the same unsigned IPA so the user can continue the SideStore loop from the project repository itself.

## Non-negotiable Rules

- No private APIs.
- No hard dependency on App Store Connect or TestFlight for the primary path.
- Deployment target kept at a level that current GitHub-hosted macOS runners can build (raise only when runners gain newer SDKs).
- Clear documentation generated into every iOS project README explaining the SideStore install steps.

## Failure Modes to Design Against

| Symptom | Mitigation |
|---------|------------|
| IPA rejected by SideStore | Strict post-archive validation of Payload structure |
| Missing entitlements | Template + export checklist |
| Certificate expiry (free Apple ID) | Document 7-day refresh cycle; keep LocalDevVPN requirement visible |
| OS version mismatch | Keep deployment target ≤ available SDK |
