import Foundation

public struct EditorSession: Identifiable, Sendable {
    public let id: UUID
    public var projectID: ProjectID
    public var openFiles: [URL]
    public var activeFile: URL?

    public init(
        id: UUID = UUID(),
        projectID: ProjectID,
        openFiles: [URL] = [],
        activeFile: URL? = nil
    ) {
        self.id = id
        self.projectID = projectID
        self.openFiles = openFiles
        self.activeFile = activeFile
    }
}
