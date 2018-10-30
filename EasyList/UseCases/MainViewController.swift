import UIKit

protocol ReloadTableDelegate {
    func shouldReloadTable()
}
class MainViewController: UIViewController, ReloadTableDelegate {
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var noteTableView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = self.children.filter{$0 is NoteViewController}.first as? NoteViewController
        vc?.reloadDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func shouldReloadTable() {
        let vc = self.children.filter{$0 is NoteTableViewController}.first as? NoteTableViewController
        vc?.tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.bottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0) {
            self.textFieldView?.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.bottomConstraint?.constant = keyboardRect.height
        
        UIView.animate(withDuration: 0) {
            self.textFieldView?.layoutIfNeeded()
        }
        
        
    }
}
