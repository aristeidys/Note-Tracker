import UIKit

protocol ReloadTableDelegate {
    func shouldReloadTable()
}
class MainViewController: KeyboardHandler, ReloadTableDelegate {
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
        let vc = self.children.filter{$0 is NoteCreateViewController}.first as? NoteCreateViewController
        vc?.reloadDelegate = self
        
        
    }
    
    func shouldReloadTable() {
        let vc = self.children.filter{$0 is NoteTableViewController}.first as? NoteTableViewController
        vc?.reload()
    }
    
    
    
}
