import UIKit
import RealmSwift

protocol NoteRepositoryLogic {
    func createNote(_ note: NoteModel)
    func getAll() -> Results<NoteModel>?
    func deleteNotes(_ notes: [NoteModel]?)
    func deleteNote(_ note: NoteModel?)
}

class NoteWorker: AbstractRepository, NoteRepositoryLogic
{
    
    func createNote(_ note: NoteModel) {
        note.editedDate = Date()
        save(entity: note)
        print("💾 Title: \(note.title) text: \(note.text)")
    }
    
    func deleteNote(_ note: NoteModel?) {
        delete(entity: note)
    }
    
    func deleteNotes(_ notes: [NoteModel]?) {
        delete(entities: notes)
    }
    
    func getAll() -> Results<NoteModel>? {
        return realm.objects(NoteModel.self)
    }
}
