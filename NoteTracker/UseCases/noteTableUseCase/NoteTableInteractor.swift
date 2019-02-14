import UIKit
import RealmSwift

protocol NoteTableInteractorLogic {
    var worker: NoteRepositoryLogic {get set}
    func fetchDataSource() -> Results<NoteModel>?
}

class NoteTableInteractor: NoteTableInteractorLogic {
    var worker: NoteRepositoryLogic = NoteWorker()
    
    func fetchDataSource() -> Results<NoteModel>? {
        return worker.getAll()
    }
}
