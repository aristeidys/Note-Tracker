@testable import NoteTracker
import XCTest
import RealmSwift

class NoteCreateInteractorTests: XCTestCase {
   
    let vc = NoteCreateViewControllerSpy()
    var sut: NoteCreateInteractor!
    let workerSpy = NoteWorkerSpy()
    
    override func setUp() {
        super.setUp()
        sut = NoteCreateInteractor(vc)
    }
    
    func test_interactor_has_worker_and_controller() {
        XCTAssertNotNil(sut.worker)
        XCTAssertNotNil(sut.viewController)
    }
    
    func test_processText_calls_worker() {
        
        sut.worker = workerSpy

        sut.processNewNote(NoteModel(text: "call Worker"))
        assert(workerSpy.createNoteCalled)
    }
    
    func test_processText_doesnt_process_empty_text() {
        
        sut.worker = workerSpy
        
        sut.processNewNote(NoteModel(text: ""))
        XCTAssertFalse(workerSpy.createNoteCalled)
    }
    
    func test_validateText_withoutText_returns_false() {
        
        // when
        sut.processNewNote(NoteModel(text: ""))
        
        // then
        assert(vc.invalidCalled)
    }
    
    func test_validateText_withText_returns_true() {
        
        // when
        sut.processNewNote(NoteModel(text: "have text"))
        
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
        func createNote(_ note: NoteModel) {
            createNoteCalled = true
        }
    }
}
