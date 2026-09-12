import SwiftUI

@main
public struct StudioApp: App {
    @StateObject private var projectStore = ProjectStore()

    public init() {}

    public var body: some Scene {
        WindowGroup {
            StudioMainView()
                .environmentObject(projectStore)
        }
    }
}

public struct StudioMainView: View {
    @EnvironmentObject private var projectStore: ProjectStore

    public init() {}

    public var body: some View {
        NavigationView {
            ProjectNavigatorView(projectStore: projectStore)
                .navigationTitle("Studio")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            projectStore.isShowingCreateSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("Create Project")
                    }
                }

            if let selected = projectStore.selectedProject {
                ProjectDetailView(project: selected)
            } else {
                Text("Select or Create a Project")
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
        }
        .sheet(isPresented: $projectStore.isShowingCreateSheet) {
            NewProjectSheet(projectStore: projectStore)
        }
    }
}

public struct ProjectDetailView: View {
    public let project: Project

    public init(project: Project) {
        self.project = project
    }

    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: project.stack.iconName)
                .font(.system(size: 64))
                .foregroundColor(.accentColor)

            Text(project.name)
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 8) {
                Label("Stack: \(project.stack.rawValue)", systemImage: "square.stack.3d.up")
                Label("Bundle ID: \(project.bundleIdentifier)", systemImage: "app.badge")
                Label("Git Repo: \(project.isGitInitialized ? "Initialized" : "None")", systemImage: "arrow.triangle.pull")
                if project.stack == .ios || project.stack == .reactNative {
                    Label("SideStore Sideloading: \(project.isSideStoreReady ? "Ready" : "Disabled")", systemImage: "arrow.down.doc")
                }
            }
            .font(.body)
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(12)

            Spacer()
        }
        .padding()
        .navigationTitle(project.name)
    }
}
