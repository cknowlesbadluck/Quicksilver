import SwiftUI

/// Sidebar/List view displaying all active projects and providing selection & detail views.
public struct ProjectNavigatorView: View {
    @ObservedObject var projectStore: ProjectStore

    public init(projectStore: ProjectStore) {
        self.projectStore = projectStore
    }

    public var body: some View {
        List {
            ForEach(projectStore.projects) { project in
                Button {
                    projectStore.selectProject(project)
                } label: {
                    HStack {
                        Image(systemName: project.stack.iconName)
                            .foregroundColor(.accentColor)
                            .frame(width: 28, height: 28)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(project.name)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(project.stack.rawValue)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        if projectStore.selectedProject?.id == project.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .onDelete { offsets in
                projectStore.deleteProjects(at: offsets)
            }
        }
        .listStyle(SidebarListStyle())
        .overlay(Group {
            if projectStore.projects.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    Text("No Projects")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Tap the '+' button above to create your first multi-stack project.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
        })
    }
}
