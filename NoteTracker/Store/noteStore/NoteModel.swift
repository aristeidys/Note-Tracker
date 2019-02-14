import UIKit
import RealmSwift

@objcMembers class NoteModel: Object {
    
    dynamic var id = 0
    dynamic var title: String = ""
    dynamic var text: String = ""
    dynamic var editedDate: Date? = nil
    
    convenience init(title: String = "", text: String = "") {
        self.init()
        self.title = title
        self.text = text
    }
}
