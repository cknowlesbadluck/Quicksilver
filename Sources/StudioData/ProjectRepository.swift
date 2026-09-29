import Foundation
import StudioDomain

/// Persistence boundary for Studio projects.
///
/// Placeholder slice so the `StudioData` target declared in Package.swift has sources and
/// builds. File-backed storage (project index + per-project metadata) lands in a later slice.
public protocol ProjectRepository: Sendable {
    func allProjects() async throws -> [Project]
    func project(id: ProjectID) async throws -> Project?
    func save(_ project: Project) async throws
    func delete(id: ProjectID) async throws
}

/// In-memory repository for previews and tests.
public actor InMemoryProjectRepository: ProjectRepository {
    private var projects: [ProjectID: Project]

    public init(projects: [Project] = []) {
        self.projects = Dictionary(projects.map { ($0.id, $0) }, uniquingKeysWith: { _, latest in latest })
    }

    public func allProjects() async throws -> [Project] {
        projects.values.sorted { $0.updatedAt > $1.updatedAt }
    }

    public func project(id: ProjectID) async throws -> Project? {
        projects[id]
    }

    public func save(_ project: Project) async throws {
        projects[project.id] = project
    }

    public func delete(id: ProjectID) async throws {
        projects[id] = nil
    }
}
