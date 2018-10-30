@testable import EasyList
import XCTest

class NotePresenterTests: XCTestCase {
    
    let sut = NotePresenter()
    let controller = NoteControllerSpy()
    
    func test_presents_placeholderText() {
        
        XCTAssertEqual(sut.placeholderText, sut.getFieldPlaceholder())
    }
    
    func test_validateText_calls_onInvalidText() {
        sut.controller = controller

        sut.validateText("")
        
        assert(controller.onInvalidCalled)
        XCTAssertFalse(controller.onValidCalled)
    }
    
    func test_validateText_calls_onValidText() {
        sut.controller = controller
        
        sut.validateText("something")
        
        XCTAssertFalse(controller.onInvalidCalled)
        assert(controller.onValidCalled)
    }
    
    class NoteControllerSpy: NoteControllerLogic {
        var onInvalidCalled = false
        var onValidCalled = false
        
        func onInvalidText() {
            onInvalidCalled = true
        }
        
        func onValidText() {
            onValidCalled = true
        }
        
        
        
    }
    
}
