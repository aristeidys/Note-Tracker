import UIKit

class MainViewController: KeyboardViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomViewConstraint = bottomConstraint
        viewToMove = textFieldView
    }
}
