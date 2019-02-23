import UIKit
import RealmSwift


protocol NoteTableViewControllerProtocol {
    var data: Results<NoteModel>? { get }
    var delegate: MainViewControllerProtocol? { get set }
    
    func getTableView() -> UITableView?
    func reload()
    func onDeletePressed()
}


class NoteTableViewController: UITableViewController, NoteTableViewControllerProtocol {
    
    var interactor: NoteTableInteractorLogic = NoteTableInteractor()

    var data: Results<NoteModel>?
    var cellId = "noteCellView"
    var delegate: MainViewControllerProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        data = interactor.fetchDataSource()
        setupGestures()
    }
    
    func setupGestures() {
        tableView.gestureRecognizers?.forEach({ (gesture) in
            gesture.addTarget(self, action: #selector(customSelector))
        })
    }
    
    @objc func customSelector() {
        delegate?.collapseCreateViewController()
    }
    
    func getTableView() -> UITableView? {
        return tableView
    }
    func reload() {
        tableView.reloadData()
        if let numOfRows = interactor.fetchDataSource()?.count,
            numOfRows > 0 {
            let indexPath = NSIndexPath(item: numOfRows - 1, section: 0)
            tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
    
    func onDeletePressed() {
        if let indexPaths = tableView.indexPathsForSelectedRows {
            
            var deleteData: [NoteModel] = []
            
            for paths in indexPaths {
                if let note = self.data?[paths.row] {
                    deleteData.append(note)
                }
            }
            
            NoteWorker().deleteNotes(deleteData)
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
    
    func deleteNote(indexPath: IndexPath) {
        NoteWorker().deleteNote(self.data?[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    
    // MARK: Table view Delegate methods
    
    var deletedIndexPaths: [IndexPath] = []
    var selectedNote: NoteModel?

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoteCellView
        
        cell?.titleLabel.isHidden = false
        
        if selectedNote != nil {
            cell!.setupView(selectedNote!)
            return cell!
        }
        guard let myCell = cell, let myData = interactor.fetchDataSource() else {
            return NoteCellView()
        }
        let note = myData[indexPath.row]
        myCell.setupView(note)
        
        if note.title == ""  {
            myCell.titleLabel.isHidden = true
        }
        
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedNote == nil {
            return interactor.fetchDataSource()?.count ?? 0

        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
            Popups.presentDeletePopup(onvc: self) {_ in
                self.deleteNote(indexPath: indexPath)
            }
        }
        return [delete]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else {
            return
        }
        performSegue(withIdentifier: "showDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue" {
            if let index = tableView.indexPathForSelectedRow?.row,
                let safeData = data,
                let destination = segue.destination as? NoteEditViewController {
                    destination.note = safeData[index]
            }
        }
    }
}
