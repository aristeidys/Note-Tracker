import Foundation

protocol NotePresenterLogic {
    var controller: NoteControllerLogic? {get set}

    func getFieldPlaceholder() -> String
    func validateText(_ text: String)
}

class NotePresenter: NotePresenterLogic {
    var controller: NoteControllerLogic?
    
    let placeholderText = "Create a Note..."
    
    func getFieldPlaceholder() -> String {
        return placeholderText
    }
    
    func validateText(_ text: String) {
        
        if text != "" {
            controller?.onValidTextSubmitted()
        } else {
            controller?.onInvalidText()
        }
    }
}
