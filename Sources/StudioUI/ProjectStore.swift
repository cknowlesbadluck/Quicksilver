import Foundation
import Combine

/// In-memory & persistent store managing project lifecycle in Quicksilver Studio.
@MainActor
public final class ProjectStore: ObservableObject {
    @Published public private(set) var projects: [Project] = []
    @Published public var selectedProject: Project?
    @Published public var isShowingCreateSheet: Bool = false

    public init(initialProjects: [Project] = []) {
        if initialProjects.isEmpty {
            // Provide default sample projects for initial preview/demo experience
            self.projects = [
                Project(
                    name: "Quicksilver Mobile",
                    stack: .ios,
                    bundleIdentifier: "com.quicksilver.studio.mobile",
                    isGitInitialized: true,
                    isSideStoreReady: true
                ),
                Project(
                    name: "Quicksilver Web Console",
                    stack: .reactWeb,
                    bundleIdentifier: "org.quicksilver.console",
                    isGitInitialized: true,
                    isSideStoreReady: false
                )
            ]
            self.selectedProject = self.projects.first
        } else {
            self.projects = initialProjects
            self.selectedProject = initialProjects.first
        }
    }

    /// Creates a new project from the provided options and sets it as active.
    @discardableResult
    public func createProject(with options: ProjectOptions) -> Project {
        let newProject = Project(options: options)
        projects.insert(newProject, at: 0)
        selectedProject = newProject
        return newProject
    }

    /// Deletes the project at the specified index set.
    public func deleteProjects(at offsets: IndexSet) {
        projects.remove(atOffsets: offsets)
        if let active = selectedProject, !projects.contains(where: { $0.id == active.id }) {
            selectedProject = projects.first
        }
    }

    /// Selects a specific project as active.
    public func selectProject(_ project: Project) {
        selectedProject = project
    }
}
