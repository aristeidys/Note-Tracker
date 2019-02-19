import Foundation

protocol NoteCreateInteractorLogic {
    func processNewNote(_ note: NoteModel)
    func validateText(_ range: NSRange, _ text: String)
}

class NoteCreateInteractor: NoteCreateInteractorLogic {
    
    var worker: NoteRepositoryLogic = NoteWorker()
    var viewController: NoteControllerLogic?
    
    init(_ vc: NoteControllerLogic) {
        viewController = vc
    }
    
    func processNewNote(_ note: NoteModel) {
        worker.createNote(note)
    }
    
    func validateText(_ range: NSRange, _ text: String) {
        if (range.contains(0) && text == "") {
            viewController?.onTextIsInvalid()
        } else {
            viewController?.onTextIsValid()
        }
    }
}
