import UIKit

protocol ReloadDelegate {
    func reload()
}
class MainViewController: KeyboardHandler, ReloadDelegate, AdjustHeightDelegate {
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createContainerHeight: NSLayoutConstraint!
    
    var tableViewController: ReloadDelegate?
    var noteCreateViewController: NoteCreateViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
        self.title = "Note Tracker"
        noteCreateViewController?.delegate = self
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
        noteCreateViewController?.collapse()
    }
    @IBAction func onTablePan(_ sender: Any) {
        noteCreateViewController?.collapse()
    }
    @IBAction func onTableSwipe(_ sender: Any) {
        noteCreateViewController?.collapse()
    }
    
    func reload() {
        tableViewController?.reload()
    }
    
    func expand(_ expand: Bool) {
        UIView.animate(withDuration: 1.5) {
            if expand {
                self.createContainerHeight.constant = 90
            } else {
                self.createContainerHeight.constant = 55
            }
        }
        
    }
    
}
