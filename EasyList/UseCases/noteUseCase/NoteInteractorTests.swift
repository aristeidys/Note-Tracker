@testable import EasyList
import XCTest

class NoteInteractorTests: XCTestCase {
   
    let sut = NoteInteractor()
    let spy = NoteWorkerSpy()
    
    func test_interactor_has_worker() {
        
        XCTAssertNotNil(sut.worker)
    }
    
    func test_saveQuickNote_calls_workers_createNote() {
        
        sut.worker = spy
        
        sut.processText( "call Worker")
        
        XCTAssertEqual(spy.text, "call Worker")
    }
    
    
    class NoteWorkerSpy: NoteRepositoryLogic {
        
        var text = ""
        func createNote(title: String, text: String) {
            self.text = text
        }
    }
}
