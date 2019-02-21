import UIKit
import DateHelper

class NoteCellView: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
        
    func setupView(_ entity: NoteModel) {
        titleLabel.text = entity.title
        descriptionLabel.text = entity.text
        dateLabel.text = entity.editedDate?.toStringWithRelativeTime()
        
        titleLabel.textColor = Colours.secondary
        descriptionLabel.textColor = Colours.text
        dateLabel.textColor = .black

        
        titleLabel.font = Fonts.bigBold
        descriptionLabel.font = Fonts.primary
        dateLabel.font = Fonts.secondary
    }
}
