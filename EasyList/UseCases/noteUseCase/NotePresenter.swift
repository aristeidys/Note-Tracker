import Foundation

protocol NotePresenterLogic {
    func getFieldPlaceholder() -> String
}

class NotePresenter: NotePresenterLogic {
    
    let placeholderText = "Create a Note..."
    
    func getFieldPlaceholder() -> String {
        return placeholderText
    }
}
