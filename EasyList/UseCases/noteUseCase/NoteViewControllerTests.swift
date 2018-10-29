@testable import EasyList
import XCTest

class NoteViewControllerTests: XCTestCase {
    
    var sut: NoteViewController!
    let presenter = NotePresenterSpy()
    let interactor = NoteInteractorSpy()

    func test_noTextInitially() {
        XCTAssertTrue(sut.textField.text == "")
    }
    
    func test_viewDidLoad_triggers_presenter_presentPlaceholder() {
        XCTAssertTrue(sut.textField.placeholder == "thePlaceholder")
    }
    
    func test_onNoteSubmited_sendsText_to_Interactor() {
        sut.textField.text = "insered Text"
        sut.submitButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(interactor.noteText == "insered Text")
    }
    
    func test_onNoteSubmited_only_if_field_filled() {
        sut.submitButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(interactor.noteText == "nil")
    }
    
    //MARK: Spys
    
    class NotePresenterSpy: NotePresenterLogic {

        func getFieldPlaceholder() -> String {
            return "thePlaceholder"
        }
    }
    
    class NoteInteractorSpy: NoteInteractorLogic {
        var noteText = "nil"
        func saveQuickNote(quickText: String) {
            noteText = quickText
        }
    }
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController
        
        sut.presenter = presenter
        sut.interactor = interactor

        _ = sut.view

    }
}

