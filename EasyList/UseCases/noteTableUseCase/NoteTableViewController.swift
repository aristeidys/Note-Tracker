import UIKit
import RealmSwift

class NoteTableViewController: UITableViewController, ReloadDelegate {
    
    var interactor: NoteTableInteractorLogic = NoteTableInteractor()

    var data: Results<NoteModel>?
    var cellId = "NoteCellView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = interactor.fetchDataSource()
        let nib = UINib.init(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.separatorColor = Colours.secondary
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func reload() {
        tableView.reloadData()
        if let numOfRows = interactor.fetchDataSource()?.count {
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
}
