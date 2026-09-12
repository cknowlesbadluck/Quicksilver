import Foundation

/// Supported tech stacks in Quicksilver Studio.
public enum StackID: String, Codable, CaseIterable, Identifiable {
    case ios = "iOS (Swift / SwiftUI)"
    case android = "Android (Kotlin / Compose)"
    case reactNative = "React Native"
    case reactWeb = "React (Web)"
    case pwa = "Progressive Web App (PWA)"

    public var id: String { rawValue }

    public var iconName: String {
        switch self {
        case .ios: return "apple.logo"
        case .android: return "phone"
        case .reactNative: return "atom"
        case .reactWeb: return "globe"
        case .pwa: return "bolt.horizontal"
        }
    }

    public var defaultBundleIdPrefix: String {
        switch self {
        case .ios, .reactNative: return "com.quicksilver.app"
        case .android: return "com.quicksilver.android"
        case .reactWeb, .pwa: return "org.quicksilver.web"
        }
    }
}

/// Options configured during project creation.
public struct ProjectOptions: Codable, Equatable {
    public var name: String
    public var stack: StackID
    public var bundleIdentifier: String
    public var initializeGit: Bool
    public var sideStoreReady: Bool

    public init(
        name: String = "",
        stack: StackID = .ios,
        bundleIdentifier: String = "com.quicksilver.app",
        initializeGit: Bool = true,
        sideStoreReady: Bool = true
    ) {
        self.name = name
        self.stack = stack
        self.bundleIdentifier = bundleIdentifier
        self.initializeGit = initializeGit
        self.sideStoreReady = sideStoreReady
    }
}

/// Domain entity representing a Quicksilver Studio project.
public struct Project: Identifiable, Codable, Equatable {
    public let id: UUID
    public var name: String
    public var stack: StackID
    public var bundleIdentifier: String
    public var isGitInitialized: Bool
    public var isSideStoreReady: Bool
    public var createdAt: Date
    public var updatedAt: Date

    public init(
        id: UUID = UUID(),
        name: String,
        stack: StackID,
        bundleIdentifier: String,
        isGitInitialized: Bool = true,
        isSideStoreReady: Bool = true,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.stack = stack
        self.bundleIdentifier = bundleIdentifier
        self.isGitInitialized = isGitInitialized
        self.isSideStoreReady = isSideStoreReady
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public init(options: ProjectOptions) {
        self.id = UUID()
        self.name = options.name
        self.stack = options.stack
        self.bundleIdentifier = options.bundleIdentifier
        self.isGitInitialized = options.initializeGit
        self.isSideStoreReady = options.sideStoreReady
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
