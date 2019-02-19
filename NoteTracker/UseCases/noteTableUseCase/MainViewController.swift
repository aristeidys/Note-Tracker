import UIKit

protocol ReloadDelegate {
    func reload()
}

protocol CollapseCreateDelegate {
    func collapseCreateViewController()
}

class MainViewController: KeyboardHandler, ReloadDelegate, AdjustHeightDelegate, CollapseCreateDelegate {
        
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createContainerHeight: NSLayoutConstraint!
    
    var tableViewController: NoteTableViewController?
    var noteCreateViewController: NoteCreateViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
        self.title = "Note Tracker"
        noteCreateViewController?.delegate = self
        tableViewController?.gesturesDelegate = self
    }
    
    // Perform Binding
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
    
    func reload() {
        tableViewController?.reload()
    }
    
    @IBAction func onTableTap(_ sender: Any) {
        collapseCreateViewController()
    }
    
    func collapseCreateViewController() {
        noteCreateViewController?.collapse()
    }
    
    func expand(_ expand: Bool) {
        if expand {
            self.createContainerHeight.constant = 95
        } else {
            self.createContainerHeight.constant = 60
        }
    }
}
