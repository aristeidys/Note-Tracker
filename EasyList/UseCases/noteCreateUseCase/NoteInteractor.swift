import Foundation

protocol NoteInteractorLogic {
    func processText(_ quickText: String?)
}

class NoteInteractor: NoteInteractorLogic {
    
    var worker: NoteRepositoryLogic = NoteWorker()
    var viewController: NoteControllerLogic?
    
    func processText(_ quickText: String?) {
        guard let text = quickText else {
            return
        }
        if isTextValid(text) {
            worker.createNote(title: "", text: text)
            viewController?.onValidTextSubmitted()
        } else {
            viewController?.onInvalidText()
        }
    }
    
    private func isTextValid(_ text: String) -> Bool {
        if text == "" {
            return false
        } else {
            return true
        }
    }
}
