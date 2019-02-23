import UIKit

protocol MainViewControllerProtocol {
    func collapseCreateViewController()
    func reload()
    func expand(_ expand: Bool)
}


class MainViewController: KeyboardHandler, MainViewControllerProtocol {
        
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var textContainerView: UIView!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var createContainerHeight: NSLayoutConstraint!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredNotes = [NoteModel]()

    @IBAction func onDeletePressed(_ sender: Any) {
        tableViewController?.onDeletePressed()
    }
    
    @IBAction func onEditPressed(_ sender: Any) {
       
        if let editing = tableViewController?.tableView.isEditing {
            tableViewController?.tableView.setEditing(!editing, animated: true)
            navigationController?.setToolbarHidden(editing, animated: true)

            UIView.animate(withDuration: 1) {
                self.bottomConstraint.constant = editing ? 5 : -65
            }
            textContainerView.isHidden = !editing
        }
    }
    
    var tableViewController: NoteTableViewController?
    var noteCreateViewController: NoteCreateViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad(noteTableView, bottomConstraint)
        self.title = "Note Tracker"
        tableViewController?.delegate = self
        noteCreateViewController?.delegate = self
        
        navigationController?.setToolbarHidden(true, animated: false)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // Perform Binding
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteTableSegue" {
            if let destination = segue.destination as? NoteTableViewController {
                tableViewController = destination
            }
        } else if segue.identifier == "noteCreateSegue" {
            if let destination = segue.destination as? NoteCreateViewController {
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

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if let data = tableViewController?.data {
            filteredNotes = data.filter({( note : NoteModel) -> Bool in
                return note.text.lowercased().contains(searchText.lowercased()) ||
                    note.description.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableViewController?.tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
