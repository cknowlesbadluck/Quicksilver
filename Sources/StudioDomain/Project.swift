import Foundation

public struct ProjectID: Hashable, Codable, Sendable {
    public let value: String
    public init(_ value: String = UUID().uuidString) {
        self.value = value
    }
}

public struct Project: Identifiable, Codable, Sendable {
    public let id: ProjectID
    public var name: String
    public var stackID: StackID
    public var rootURL: URL?
    public var createdAt: Date
    public var updatedAt: Date

    public init(
        id: ProjectID = ProjectID(),
        name: String,
        stackID: StackID,
        rootURL: URL? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.stackID = stackID
        self.rootURL = rootURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public enum StackID: String, Codable, CaseIterable, Sendable {
    case nativeIOS = "native-ios"
    case nativeAndroid = "native-android"
    case reactNative = "react-native"
    case reactWeb = "react-web"
    case pwa = "pwa"

    public var displayName: String {
        switch self {
        case .nativeIOS: return "Native iOS"
        case .nativeAndroid: return "Native Android"
        case .reactNative: return "React Native"
        case .reactWeb: return "React (Web)"
        case .pwa: return "Progressive Web App"
        }
    }
}
