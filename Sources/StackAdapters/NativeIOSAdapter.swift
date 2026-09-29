import Foundation
import StudioDomain

public struct NativeIOSAdapter: StackAdapter {
    public let id: StackID = .nativeIOS
    public let displayName = "Native iOS"
    public let supportedFileExtensions = ["swift", "plist", "xcassets", "storyboard", "xib"]

    public init() {}

    public func createProject(named: String, options: ProjectOptions) async throws -> Project {
        // Stub — real XcodeGen / template generation comes in the next slice
        Project(name: named, stackID: .nativeIOS)
    }

    public func openProject(at url: URL) async throws -> Project {
        Project(name: url.lastPathComponent, stackID: .nativeIOS, rootURL: url)
    }

    public func build(project: Project, configuration: BuildConfiguration) async throws -> BuildArtifact {
        throw StudioError.notImplemented("build")
    }

    public func exportForSideStore(project: Project) async throws -> URL? {
        // Matches QuicksilverV1 SideStore path — unsigned IPA preferred
        nil
    }
}

enum StudioError: Error, LocalizedError {
    case notImplemented(String)

    var errorDescription: String? {
        switch self {
        case .notImplemented(let feature):
            return "\(feature) is not yet implemented in this adapter"
        }
    }
}
