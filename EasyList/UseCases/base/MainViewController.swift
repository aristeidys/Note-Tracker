import UIKit

protocol ReloadTableDelegate {
    func shouldReloadTable()
}
class MainViewController: KeyboardHandler, ReloadTableDelegate {
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var noteTableSegue = "noteTableSegue"
    var tableViewController: ReloadTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
        let vc = self.children.filter{$0 is NoteCreateViewController}.first as? NoteCreateViewController
        vc?.reloadDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == noteTableSegue {
            if let destination = segue.destination as? NoteTableViewController {
                tableViewController = destination
            }
        }
    }
    
    
    func shouldReloadTable() {
        tableViewController?.shouldReloadTable()
    }
    
    
    
}
