import UIKit

protocol ReloadDelegate {
    func reload()
}
class MainViewController: KeyboardHandler, ReloadDelegate {
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var tableViewController: ReloadDelegate?
    var noteCreateViewController: NoteCreateViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteTableSegue" {
            if let destination = segue.destination as? NoteTableViewController {
                tableViewController = destination
            }
        } else if segue.identifier == "noteCreateSegue" {
            if let destination = segue.destination as? NoteCreateViewController {
                destination.reloadDelegate = self
                noteCreateViewController = destination
            }
        }
    }
    @IBAction func onTableClick(_ sender: Any) {
        noteCreateViewController?.textField.resignFirstResponder()
    }
    
    func reload() {
        tableViewController?.reload()
    }
    
    
    
}
