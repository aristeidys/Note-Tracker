import UIKit
import RealmSwift

protocol NoteRepositoryLogic {
    func createNote(title: String, text: String)
    func getAll() -> Results<NoteModel>?
}

class NoteWorker: AbstractRepository, NoteRepositoryLogic
{
    
    func createNote(title: String = "", text: String = "") {
        let note = NoteModel(title: title)
        note.title = title
        note.text = text
        save(entity: note)
        print("💾 Title: \(title) text: \(text)")
    }
    
    func getAll() -> Results<NoteModel>? {
        return realm.objects(NoteModel.self)
    }
}
