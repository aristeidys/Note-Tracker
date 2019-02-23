
import UIKit


protocol NoteCreateViewControllerProtocol {
    var delegate: MainViewControllerProtocol? { get set }
    
    func onTextIsInvalid()
    func onTextIsValid()
    func collapse()
}

class NoteCreateViewController: UIViewController, NoteCreateViewControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var delegate: MainViewControllerProtocol?
    
    var interactor: NoteCreateInteractorLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do Binding
        descTextField.delegate = self
        titleTextField.delegate = self
        interactor = NoteCreateInteractor(self)
        titleTextField.isHidden = true
    }
    
    
    //MARK: Actions
    
    @IBAction func onNoteSubmitted(_ sender: Any) {
        let note = NoteModel(title: titleTextField.text ?? "", text: descTextField?.text ?? "")
        interactor?.processNewNote(note)
        onTextIsInvalid()

        descTextField.text = ""
        titleTextField.text = ""
        
        delegate?.reload()
    }
    
    @IBAction func onMoreClicked(_ sender: Any) {
        let isExpanded = !titleTextField.isHidden
        titleTextField.isHidden = isExpanded
        let icon = !isExpanded ? UIImage(named: "icons8-down-button-40") : UIImage(named: "icons8-slide-up-40")
        moreButton.setImage(icon, for: .normal)
        
        delegate?.expand(!isExpanded)
    }
    
    
    //MARK: textField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if descTextField.isFirstResponder {
            interactor?.validateText(range, string)
        }
        return true
    }
    
    
    //MARK: callbacks
    
    func collapse() {
        moreButton.setImage(UIImage(named: "icons8-slide-up-40"), for: .normal)
        self.descTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
        self.titleTextField.isHidden = true
        delegate?.expand(false)
    }

    func onTextIsValid() {
        submitButton.isEnabled = true
    }
    
    func onTextIsInvalid() {
        submitButton.isEnabled = false
    }
}
