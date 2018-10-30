import UIKit
import RealmSwift

class NoteTableViewController: UITableViewController {
    
    var interactor: NoteTableInteractorLogic = NoteTableInteractor()
    
    var data: Results<NoteModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = interactor.fetchDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        data = interactor.fetchDataSource()
        tableView.reloadData()
    }
    
    // MARK: Table view Delegates
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellView", for: indexPath) as? NoteCellView
        guard let myCell = cell, let myData = data else {
            return NoteCellView()
        }
        myCell.setupView(myData[indexPath.row])
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
}
