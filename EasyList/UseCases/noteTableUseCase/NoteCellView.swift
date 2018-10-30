import UIKit

class NoteCellView: UITableViewCell {
    
    @IBOutlet weak var textLabelView: UILabel!
    @IBOutlet weak var dateLabelView: UILabel!
    
    func setupView(_ entity: NoteModel) {
        textLabelView.text = entity.text
        if let date = entity.editedDate {
            dateLabelView.text = date.description
        }
    }
}
