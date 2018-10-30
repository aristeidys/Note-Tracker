@testable import EasyList
import XCTest

class NoteInteractorTests: XCTestCase {
   
    let sut = NoteInteractor()
    let workerSpy = NoteWorkerSpy()
    let presenterSpy = NotePresenterSpy()
    
    func test_interactor_has_worker() {
        XCTAssertNotNil(sut.worker)
    }
    
    func test_processText_calls_workerAndPresenter() {
        
        sut.worker = workerSpy
        sut.presenter = presenterSpy

        sut.processText( "call Worker")
        assert(workerSpy.createNoteCalled)
        assert(presenterSpy.validateTextCalled)
    }
    
    func test_processText_doesnt_process_empty_text() {
        
        sut.worker = workerSpy
        sut.presenter = presenterSpy
        
        sut.processText( "")
        XCTAssertFalse(workerSpy.createNoteCalled)
        assert(presenterSpy.validateTextCalled)
    }
    
    func test_processText_doesnt_call_workerAndPresenter() {
        
        sut.worker = workerSpy
        sut.presenter = presenterSpy
        
        sut.processText(nil)
        XCTAssertFalse(workerSpy.createNoteCalled)
        XCTAssertFalse(presenterSpy.validateTextCalled)
    }
    
    class NoteWorkerSpy: NoteRepositoryLogic {
        
        var createNoteCalled = false
        func createNote(title: String, text: String) {
            createNoteCalled = true
        }
    }
    
    class NotePresenterSpy: NotePresenterLogic {
        var controller: NoteControllerLogic?
        var validateTextCalled = false
        
        func getFieldPlaceholder() -> String {
            return ""
        }
        
        func validateText(_ text: String) {
            validateTextCalled = true
        }
    }
}
