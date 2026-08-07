import Foundation

public protocol StackAdapter: Sendable {
    var id: StackID { get }
    var displayName: String { get }
    var supportedFileExtensions: [String] { get }

    func createProject(named: String, options: ProjectOptions) async throws -> Project
    func openProject(at url: URL) async throws -> Project
    func build(project: Project, configuration: BuildConfiguration) async throws -> BuildArtifact
    func exportForSideStore(project: Project) async throws -> URL?
}

public struct ProjectOptions: Sendable {
    public var template: String?
    public var includeTests: Bool

    public init(template: String? = nil, includeTests: Bool = true) {
        self.template = template
        self.includeTests = includeTests
    }
}

public struct BuildConfiguration: Sendable {
    public var configuration: String // "Debug" | "Release"
    public var destination: String

    public init(configuration: String = "Debug", destination: String = "generic/platform=iOS") {
        self.configuration = configuration
        self.destination = destination
    }
}

public struct BuildArtifact: Sendable {
    public let url: URL
    public let kind: Kind

    public enum Kind: String, Sendable {
        case ipa
        case app
        case apk
        case aab
        case bundle
        case other
    }

    public init(url: URL, kind: Kind) {
        self.url = url
        self.kind = kind
    }
}
