@testable import EasyList
import XCTest

class NoteCreateViewControllerTests: XCTestCase {
    
    var sut: NoteCreateViewController!
    let interactor = NoteCreateInteractorSpy()

    func test_noTextInitially() {
        XCTAssert(sut.textField.text == "")
    }
    
    func test_viewDidLoad_setsFieldDelegate() {
        assert(sut.textField!.delegate === sut)
    }
    
    func test_onNoteSubmited_sendsText_to_Interactor() {
        sut.textField.text = "insered Text"
        sut.submitButton.sendActions(for: .touchUpInside)

        XCTAssert(interactor.noteText == "insered Text")
    }
    
    func test_onValidText_clearsText() {
        sut.textField.text = "insered Text"

        sut.onValidTextSubmitted()
        
        assert(sut.textField.text == "")
    }
    
    func test_onInvalidText_showsUnderline() {
        XCTAssertFalse(sut.textField.onlyOneUnderlineExists())
        
        sut.onInvalidText()
        
        assert(sut.textField.onlyOneUnderlineExists())
    }
    
    func test_onStartTyping_hideUnderline() {
        sut.textField.text = "hi"
        sut.onInvalidText()
        
        assert(sut.textField.onlyOneUnderlineExists())
        
        _ = sut.textField(sut.textField, shouldChangeCharactersIn: NSRange(location: 0, length: 1), replacementString: "hello world")
        
        XCTAssertFalse(sut.textField.onlyOneUnderlineExists())
    }
    
    //MARK: Spys
    
    class NoteCreateInteractorSpy: NoteCreateInteractorLogic {

        var noteText = "nil"
        func processText(_ quickText: String?) {
            if let text = quickText {
                noteText = text
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "NoteCreateViewController") as? NoteCreateViewController
        
        _ = sut.view
        
        sut.interactor = interactor
    }
}

