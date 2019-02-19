import UIKit
import RealmSwift

class NoteTableViewController: UITableViewController, ReloadDelegate {
    
    var interactor: NoteTableInteractorLogic = NoteTableInteractor()

    var data: Results<NoteModel>?
    var cellId = "NoteCellView"
    var gesturesDelegate: CollapseCreateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = interactor.fetchDataSource()
        let nib = UINib.init(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.separatorColor = Colours.secondary
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func setupGestures() {
        tableView.gestureRecognizers?.forEach({ (gesture) in
            gesture.addTarget(self, action: #selector(customSelector))
        })
    }
    
    @objc func customSelector() {
        gesturesDelegate.collapseCreateViewController()
    }
    
    func reload() {
        tableView.reloadData()
        if let numOfRows = interactor.fetchDataSource()?.count,
            numOfRows > 0 {
            let indexPath = NSIndexPath(item: numOfRows - 1, section: 0)
            tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
    
    // MARK: Table view Delegates
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoteCellView
        guard let myCell = cell, let myData = interactor.fetchDataSource() else {
            return NoteCellView()
        }
        myCell.setupView(myData[indexPath.row])
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.fetchDataSource()?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
            let alert = UIAlertController.init(title: "Are you sure?", message: "This action cannot be undone.", preferredStyle: .actionSheet)
            let continueAction = UIAlertAction.init(title: "Continue", style: .destructive, handler: {(action) in  self.deleteNote(indexPath: indexPath) } )
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: {(action) in } )
            alert.addAction(continueAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func deleteNote(indexPath: IndexPath) {
        NoteWorker().deleteNote(self.data?[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .automatic)
        reload()
    }
}
