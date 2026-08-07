# Quicksilver Studio

**Native iOS App Builder / Editor** for multi-stack projects.

Quicksilver Studio is the Forge surface of the Quicksilver intelligence platform. It is a native iOS application (iPhone + iPad) that lets users create, edit, preview, build, and manage applications across multiple technology stacks while remaining fully GitHub-compatible and SideStore-ready.

## Supported Stacks

| Stack | Status |
|-------|--------|
| Native iOS (Swift + SwiftUI / UIKit) | Scaffolded |
| Native Android (Kotlin + Jetpack Compose) | Planned |
| React Native | Planned |
| React (web) | Planned |
| Progressive Web Apps (PWAs) | Planned |

## Current Status (this branch)

- Domain models (`Project`, `StackID`, `EditorSession`)
- `StackAdapter` protocol (the single extension point for new platforms)
- Minimal SwiftUI shell (`ProjectNavigatorView`)
- `NativeIOSAdapter` stub that respects SideStore export contract
- SPM package layout ready for expansion

## Core Requirements (non-negotiable)

- **GitHub**: Full native Git (clone / branch / commit / push / pull / merge / PR), OAuth/PAT/GitHub App auth via Keychain, Actions awareness, offline-first sync.
- **SideStore**: The Studio app itself and every iOS-targeted project it generates must produce installable IPAs for SideStore (unsigned path preferred; signed optional).
- **Architecture**: Strict modular / feature-based design with stack adapters. Protocol-oriented, dependency-injected, concurrency-safe.

## System Prompt

The authoritative system prompt that drives architecture, implementation, and code review lives here:

- [`prompts/SYSTEM_PROMPT.md`](prompts/SYSTEM_PROMPT.md)

Use it as the system message for any agent or session that designs or implements Studio features.

## Documentation

- [Architecture Overview](Documentation/ARCHITECTURE.md)
- [SideStore Compatibility](Documentation/SIDESTORE.md)
- [GitHub Workflow](Documentation/GITHUB.md)

## Next Implementation Priority

1. Domain models + ProjectStore ✅ (started)
2. GitEngine + credential flow
3. iOS StackAdapter (templates + basic editor + SideStore export)
4. Minimal SwiftUI shell (navigator + editor + preview placeholder) ✅ (started)
5. React Native / PWA adapters

---

Part of the Quicksilver project · SideStore-first · Privacy-first · Modular
