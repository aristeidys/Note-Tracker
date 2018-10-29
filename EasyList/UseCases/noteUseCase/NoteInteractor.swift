import Foundation

protocol NoteInteractorLogic {
    func saveQuickNote(quickText: String)
}

class NoteInteractor: NoteInteractorLogic {
    var worker: NoteRepositoryLogic = NoteWorker()
    
    func saveQuickNote(quickText: String) {
        
        worker.createNote(title: "", text: quickText)
    }
}
