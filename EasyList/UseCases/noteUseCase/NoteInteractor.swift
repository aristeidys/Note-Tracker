import Foundation

protocol NoteInteractorLogic {
    func processText(_ quickText: String)
}

class NoteInteractor: NoteInteractorLogic {
    var worker: NoteRepositoryLogic = NoteWorker()
    
    func processText(_ quickText: String) {
        
        worker.createNote(title: "", text: quickText)
    }
}
