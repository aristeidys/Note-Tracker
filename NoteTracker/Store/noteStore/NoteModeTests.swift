@testable import NoteTracker
import XCTest

class NoteModeTests: XCTestCase {

    func testNoteModeInitiallization() {
        
        _ = NoteModel(title: "hello")
        _ = NoteModel(title: "dfds", text: "fdf")
        
    }

}
