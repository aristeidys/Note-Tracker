
import UIKit


protocol NoteControllerLogic {
    func onTextIsInvalid()
    func onTextIsValid()
}

protocol AdjustHeightDelegate {
    func expand(_ expand: Bool)
}

class NoteCreateViewController: UIViewController, NoteControllerLogic, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var delegate: AdjustHeightDelegate?
    
    var reloadDelegate: ReloadDelegate?
    var interactor: NoteCreateInteractorLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do Binding
        submitButton.setTitleColor(Colours.buttons, for: .normal)
        submitButton.setTitleColor(Colours.secondary, for: .highlighted)
        descTextField.delegate = self
        titleTextField.delegate = self
        interactor = NoteCreateInteractor(self)
        titleTextField.isHidden = true
    }
    
    @IBAction func onNoteSubmitted(_ sender: Any) {
        let note = NoteModel(title: titleTextField.text ?? "", text: descTextField?.text ?? "")
        interactor?.processNewNote(note)
        
        descTextField.text = ""
        titleTextField.text = ""
        
        reloadDelegate?.reload()
    }
    
    @IBAction func onMoreClicked(_ sender: Any) {
        let isExpanded = !titleTextField.isHidden
        titleTextField.isHidden = isExpanded
        let icon = !isExpanded ? UIImage(named: "icons8-down-button-40") : UIImage(named: "icons8-slide-up-40")
        moreButton.setImage(icon, for: .normal)
        
        delegate?.expand(!isExpanded)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if descTextField.isFirstResponder {
            interactor?.validateText(range, string)
        }
        return true
    }
    
    //MARK: callbacks
    func onGesture() {
        collapse()
    }
    
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
