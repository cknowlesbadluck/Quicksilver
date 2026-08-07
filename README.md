# Quicksilver Studio

**Native iOS App Builder / Editor** for multi-stack projects.

Quicksilver Studio is the Forge surface of the Quicksilver intelligence platform. It is a native iOS application (iPhone + iPad) that lets users create, edit, preview, build, and manage applications across multiple technology stacks while remaining fully GitHub-compatible and SideStore-ready.

## Supported Stacks

| Stack | Status |
|-------|--------|
| Native iOS (Swift + SwiftUI / UIKit) | First-class |
| Native Android (Kotlin + Jetpack Compose) | First-class |
| React Native | First-class |
| React (web) | First-class |
| Progressive Web Apps (PWAs) | First-class |

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

## Status

Initial prompt and architecture committed. Implementation of the native iOS Studio shell and first stack adapters is next.

---

Part of the Quicksilver project · SideStore-first · Privacy-first · Modular
