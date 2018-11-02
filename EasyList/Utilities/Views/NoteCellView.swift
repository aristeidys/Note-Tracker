import UIKit

class NoteCellView: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(_ entity: NoteModel) {
        titleLabel.text = entity.title
        descriptionLabel.text = entity.text
        
        titleLabel.textColor = Colours.secondary
        descriptionLabel.textColor = Colours.text
        
        titleLabel.font = Fonts.bigBold
        descriptionLabel.font = Fonts.primary
    }
}
