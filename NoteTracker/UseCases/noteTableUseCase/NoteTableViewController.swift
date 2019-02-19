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
    
    func deleteNote(indexPath: IndexPath) {
        NoteWorker().deleteNote(self.data?[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.reloadData()
    }
    
    // MARK: Table view Delegates
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoteCellView
        
        if selectedNote != nil {
            cell!.setupView(selectedNote!)
            return cell!
        }
        guard let myCell = cell, let myData = interactor.fetchDataSource() else {
            return NoteCellView()
        }
        myCell.setupView(myData[indexPath.row])
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
        if selectedNote != nil {
            tableView.performBatchUpdates({
                self.selectedNote = nil
                tableView.insertRows(at: deletedIndexPaths, with: .middle)
                deletedIndexPaths = []
                tableView.deselectRow(at: indexPath, animated: true)
            })
            return
        }
        
        for (index, _) in data!.enumerated() {
            if index != indexPath.row {
                deletedIndexPaths.append(IndexPath(row: index, section: indexPath.section))
            }
        }
        
        tableView.performBatchUpdates({
            tableView.deleteRows(at: deletedIndexPaths, with: UITableView.RowAnimation.middle)
            self.selectedNote = self.data?[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
    
    var deletedIndexPaths: [IndexPath] = []
    var selectedNote: NoteModel?
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedNote != nil) {
            return view.frame.height
        } else {
            return UITableView.automaticDimension
        }
        
        
    }
}
