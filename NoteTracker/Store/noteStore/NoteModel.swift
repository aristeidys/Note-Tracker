import UIKit
import RealmSwift

@objcMembers class NoteModel: Object {
    
    dynamic var title: String = ""
    dynamic var text: String = ""
    dynamic var editedDate: Date? = nil
    dynamic var pathToRecording: String? = nil

    convenience init(title: String = "", text: String = "") {
        self.init()
        self.title = title
        self.text = text
    }
}
