import Foundation

protocol NoteCreateInteractorLogic {
    func processText(_ quickText: String?)
}

class NoteCreateInteractor: NoteCreateInteractorLogic {
    
    var worker: NoteRepositoryLogic = NoteWorker()
    var viewController: NoteControllerLogic?
    
    init(_ vc: NoteControllerLogic) {
        viewController = vc
    }
    
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
        return  text == "" ? false : true
    }
}
