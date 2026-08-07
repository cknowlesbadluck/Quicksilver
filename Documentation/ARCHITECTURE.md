# Quicksilver Studio — Architecture

## Vision

Quicksilver Studio is the creation surface of the Quicksilver intelligence platform.  
It is a native iOS app that lets a user design, edit, preview, and ship applications across multiple technology stacks without leaving the device (or with optional cloud build support).

The Studio itself lives inside the same modular philosophy as the rest of Quicksilver: strict boundaries, protocol-oriented design, SideStore-first distribution, and GitHub as the source of truth.

## High-Level Structure

```
QuicksilverStudio (native iOS host)
├── Domain
│   ├── Project
│   ├── Stack
│   ├── EditorSession
│   └── BuildArtifact
├── Data
│   ├── GitRepository
│   ├── ProjectStore
│   └── CredentialStore (Keychain)
├── Presentation (SwiftUI)
│   ├── ProjectNavigator
│   ├── CodeEditor
│   ├── LivePreview
│   ├── BuildConsole
│   └── ExportSheet (SideStore IPA)
├── Infrastructure
│   ├── GitEngine (libgit2 / SwiftGit2)
│   ├── FileSystem
│   └── Network
└── StackAdapters
    ├── iOSAdapter (Swift / SwiftUI)
    ├── AndroidAdapter (Kotlin / Compose)
    ├── ReactNativeAdapter
    ├── ReactWebAdapter
    └── PWAAdapter
```

## Stack Adapter Contract

Every stack implements a common protocol surface:

```swift
protocol StackAdapter {
    var id: StackID { get }
    var displayName: String { get }
    var supportedFileExtensions: [String] { get }

    func createProject(named: String, options: ProjectOptions) async throws -> Project
    func openProject(at url: URL) async throws -> Project
    func languageServer(for file: ProjectFile) -> LanguageServer?
    func previewProvider(for project: Project) -> PreviewProvider?
    func build(project: Project, configuration: BuildConfiguration) async throws -> BuildArtifact
    func exportForSideStore(project: Project) async throws -> URL?  // only for iOS-capable stacks
}
```

New stacks are added by implementing this protocol and registering the adapter. Core Studio code never hard-codes stack-specific logic.

## GitHub Integration Layer

- Authentication: OAuth / PAT / GitHub App → Keychain
- Operations: clone, fetch, pull, push, branch, merge, rebase, conflict markers
- UI surfaces: repository browser, PR creation sheet, Actions status badges
- Offline-first: local Git working copy is the source of truth; sync is opportunistic

## SideStore / Signing Layer

- Studio app itself is archived via the same GitHub Actions path used by QuicksilverV1 (unsigned IPA preferred).
- For iOS projects created inside Studio:
  - Generate correct entitlements and Info.plist
  - Produce unsigned IPA (SideStore re-signs)
  - Optional development-signed path when certificate secrets are available
- One-tap “Export for SideStore” that packages and surfaces the IPA for download / AirDrop / Files.

## Dependency Direction

```
Presentation → Domain ← Data
       ↓           ↓
 Infrastructure  StackAdapters
```

UI never talks directly to Git or to a specific language server. Domain orchestrates; adapters provide the concrete behavior.

## Decision Records (initial)

| ID | Decision | Rationale |
|----|----------|-----------|
| DR-001 | Studio is native iOS only (host) | Aligns with Quicksilver primary device and SideStore path |
| DR-002 | Stacks are pure adapters | Keeps core stable; new platforms do not require core changes |
| DR-003 | Unsigned IPA is the default export | Matches QuicksilverV1 SideStore workflow; no secrets required |
| DR-004 | Git is first-class, not an afterthought | Every generated project must be immediately pushable to GitHub |

## Explicitly Deferred (v1)

- Full multi-window iPad Stage Manager advanced layouts
- On-device Android emulator
- Full Xcode project generation with every possible capability
- Cloud Mac build farm beyond GitHub Actions

## Next Implementation Priority

1. Domain models + ProjectStore
2. GitEngine + credential flow
3. iOS StackAdapter (templates + basic editor + SideStore export)
4. Minimal SwiftUI shell (navigator + editor + preview placeholder)
5. React Native / PWA adapters
