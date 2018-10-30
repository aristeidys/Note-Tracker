import Foundation

protocol NoteInteractorLogic {
    var presenter: NotePresenterLogic? {get set}
    func processText(_ quickText: String?)
}

class NoteInteractor: NoteInteractorLogic {
    var presenter: NotePresenterLogic?
    
    var worker: NoteRepositoryLogic = NoteWorker()
    
    func processText(_ quickText: String?) {
        guard let text = quickText else {
            return
        }
        if text != "" {
            worker.createNote(title: "", text: text)
        }
        presenter?.validateText(text)
    }
}
