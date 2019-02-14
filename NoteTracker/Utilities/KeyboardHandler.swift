import UIKit

class KeyboardHandler: UIViewController {
    
    var fieldView: UIView?
    var theConstraint: NSLayoutConstraint?
    
    func viewDidLoad(_ textField: UIView, _ constraint: NSLayoutConstraint) {
        super.viewDidLoad()
        fieldView = textField
        theConstraint = constraint
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillHide(notification: Notification) {
        self.theConstraint?.constant = 0
        
        UIView.animate(withDuration: 0) {
            self.fieldView?.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.theConstraint?.constant = keyboardRect.height
        
        UIView.animate(withDuration: 0) {
            self.fieldView?.layoutIfNeeded()
        }
    }
}
