# GitHub Integration — Quicksilver Studio

## Principles

1. Git is the source of truth.
2. Every project created or opened in Studio must be immediately usable as a normal GitHub repository.
3. Offline-first: the local working copy is always available; network is opportunistic.
4. Authentication secrets never leave Keychain.

## Required Capabilities

- Clone (HTTPS + SSH where feasible)
- Fetch / Pull / Push
- Branch create / switch / delete
- Stage / Commit (with co-author and conventional-commit helpers)
- Merge / Rebase with conflict marker support
- Create Pull Request (title, body, base/head, draft)
- Read Actions status and checks
- Basic Issues / Releases surface (read + create)

## Authentication

Supported methods (in order of preference):

1. GitHub App installation (recommended for multi-repo)
2. OAuth App flow
3. Personal Access Token (classic or fine-grained)

All tokens and app credentials are stored in the iOS Keychain via the shared Quicksilver KeychainStore pattern.

## Generated Project Expectations

When Studio scaffolds a new project it must also write:

- `.gitignore` appropriate to the stack
- `README.md` with SideStore (if iOS) and local development instructions
- GitHub Actions workflow(s) for CI + (for iOS) Archive IPA
- Proper license stub or placeholder

The resulting repository should pass a “first push” test with zero manual cleanup.

## Offline Behavior

- All editor and preview features work on the local checkout.
- Sync status is visible in the UI.
- Conflicts are surfaced clearly when a pull or push cannot complete cleanly.
