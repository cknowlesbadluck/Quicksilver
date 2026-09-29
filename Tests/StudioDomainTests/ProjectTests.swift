import XCTest
@testable import StudioDomain

final class ProjectTests: XCTestCase {
    func testProjectIsHashableForNavigation() {
        let id = ProjectID("fixed")
        let date = Date(timeIntervalSince1970: 0)
        let first = Project(id: id, name: "Demo", stackID: .nativeIOS, createdAt: date, updatedAt: date)
        let second = Project(id: id, name: "Demo", stackID: .nativeIOS, createdAt: date, updatedAt: date)
        XCTAssertEqual(first, second)
        XCTAssertEqual(Set([first, second]).count, 1)
    }

    func testProjectCodableRoundTrip() throws {
        let date = Date(timeIntervalSince1970: 1_700_000_000)
        let project = Project(
            id: ProjectID("p1"),
            name: "Round Trip",
            stackID: .reactWeb,
            rootURL: URL(fileURLWithPath: "/tmp/round-trip"),
            createdAt: date,
            updatedAt: date
        )
        let decoded = try JSONDecoder().decode(Project.self, from: JSONEncoder().encode(project))
        XCTAssertEqual(decoded, project)
    }

    func testEveryStackHasADisplayName() {
        for stack in StackID.allCases {
            XCTAssertFalse(stack.displayName.isEmpty, "\(stack) has no display name")
        }
    }

    func testEditorSessionDefaults() {
        let session = EditorSession(projectID: ProjectID("p1"))
        XCTAssertTrue(session.openFiles.isEmpty)
        XCTAssertNil(session.activeFile)
    }
}
