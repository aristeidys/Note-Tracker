@testable import EasyList
import XCTest
import RealmSwift

class NoteCreateInteractorTests: XCTestCase {
   
    let sut = NoteCreateInteractor()
    let workerSpy = NoteWorkerSpy()
    
    func test_interactor_has_worker() {
        XCTAssertNotNil(sut.worker)
    }
    
    func test_processText_calls_worker() {
        
        sut.worker = workerSpy

        sut.processText( "call Worker")
        assert(workerSpy.createNoteCalled)
    }
    
    func test_processText_doesnt_process_empty_text() {
        
        sut.worker = workerSpy
        
        sut.processText( "")
        XCTAssertFalse(workerSpy.createNoteCalled)
    }
    
    func test_processText_doesnt_call_worker() {
        
        sut.worker = workerSpy
        
        sut.processText(nil)
        XCTAssertFalse(workerSpy.createNoteCalled)
    }
    
    func test_validateText_withoutText_returns_false() {
        
        let vc = NoteCreateViewControllerSpy()
        sut.viewController = vc
        
        // when
        sut.processText("")
        
        // then
        assert(vc.invalidCalled)
    }
    
    func test_validateText_withText_returns_true() {
        
        let vc = NoteCreateViewControllerSpy()
        sut.viewController = vc
        
        // when
        sut.processText("have text")
        
        // then
        assert(vc.validCalled)
    }
    
    // MARK: Spys
    
    class NoteCreateViewControllerSpy: NoteControllerLogic {
        var invalidCalled = false
        
        func onInvalidText() {
            invalidCalled = true
        }
        
        var validCalled = false
        
        func onValidTextSubmitted() {
            validCalled = true
        }
        
        
    }
    
    class NoteWorkerSpy: NoteRepositoryLogic {
        
        func getAll() -> Results<NoteModel>? {
            return nil
        }
        
        var createNoteCalled = false
        func createNote(title: String, text: String) {
            createNoteCalled = true
        }
    }
}
