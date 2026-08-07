import SwiftUI
import StudioDomain

@main
struct QuicksilverStudioApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectNavigatorView()
        }
    }
}

struct ProjectNavigatorView: View {
    @State private var projects: [Project] = []

    var body: some View {
        NavigationStack {
            List {
                if projects.isEmpty {
                    ContentUnavailableView(
                        "No Projects",
                        systemImage: "folder.badge.plus",
                        description: Text("Create a new project or clone from GitHub.")
                    )
                } else {
                    ForEach(projects) { project in
                        NavigationLink(value: project) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(project.name)
                                    .font(.headline)
                                Text(project.stackID.displayName)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Studio")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Placeholder — real create flow comes next
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Project.self) { project in
                Text("Editor for \(project.name)")
                    .navigationTitle(project.name)
            }
        }
    }
}

#Preview {
    ProjectNavigatorView()
}
