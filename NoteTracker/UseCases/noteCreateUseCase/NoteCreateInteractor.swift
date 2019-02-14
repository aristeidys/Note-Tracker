import Foundation

protocol NoteCreateInteractorLogic {
    func processNewNote(_ note: NoteModel)
}

class NoteCreateInteractor: NoteCreateInteractorLogic {
    
    var worker: NoteRepositoryLogic = NoteWorker()
    var viewController: NoteControllerLogic?
    
    init(_ vc: NoteControllerLogic) {
        viewController = vc
    }
    
    func processNewNote(_ note: NoteModel) {

        if isTextValid(note.text) {
            worker.createNote(note)
            viewController?.onValidTextSubmitted()
        } else {
            viewController?.onInvalidText()
        }
    }
    
    private func isTextValid(_ text: String) -> Bool {
        return  text == "" ? false : true
    }
}
