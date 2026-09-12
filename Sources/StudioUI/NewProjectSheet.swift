import SwiftUI

/// Form sheet for creating a new project with multi-stack support and SideStore configuration.
public struct NewProjectSheet: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var projectStore: ProjectStore

    @State private var options = ProjectOptions()
    @State private var validationError: String?

    public init(projectStore: ProjectStore) {
        self.projectStore = projectStore
    }

    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Project Information")) {
                    TextField("Project Name", text: $options.name)
                        .autocapitalization(.words)
                        .onChange(of: options.name) { newValue in
                            updateDefaultBundleId(for: newValue, stack: options.stack)
                        }

                    Picker("Target Stack", selection: $options.stack) {
                        ForEach(StackID.allCases) { stack in
                            Label(stack.rawValue, systemImage: stack.iconName)
                                .tag(stack)
                        }
                    }
                    .onChange(of: options.stack) { newStack in
                        updateDefaultBundleId(for: options.name, stack: newStack)
                    }

                    TextField("Bundle Identifier / Package", text: $options.bundleIdentifier)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }

                Section(header: Text("Version Control & Export")) {
                    Toggle("Initialize Git Repository", isOn: $options.initializeGit)

                    if options.stack == .ios || options.stack == .reactNative {
                        Toggle("SideStore Sideloading Ready", isOn: $options.sideStoreReady)
                    }
                }

                if let error = validationError {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("New Project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        handleCreate()
                    }
                    .disabled(options.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func updateDefaultBundleId(for name: String, stack: StackID) {
        let sanitizedName = name
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
        let suffix = sanitizedName.isEmpty ? "app" : sanitizedName
        options.bundleIdentifier = "\(stack.defaultBundleIdPrefix).\(suffix)"
    }

    private func handleCreate() {
        let trimmedName = options.name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            validationError = "Project name cannot be empty."
            return
        }

        projectStore.createProject(with: options)
        dismiss()
    }
}
