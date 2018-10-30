import UIKit
import RealmSwift

class NoteTableViewController: UITableViewController {
    
    var interactor: NoteTableInteractorLogic = NoteTableInteractor()
    
    var data: Results<NoteModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = interactor.fetchDataSource()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
}
