
import UIKit


protocol NoteControllerLogic {
    func onInvalidText()
    func onValidTextSubmitted()
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
        reloadDelegate?.reload()
    }
    
    @IBAction func onMoreClicked(_ sender: Any) {
        let isExpanded = !titleTextField.isHidden
        titleTextField.isHidden = isExpanded
        let icon = !isExpanded ? UIImage(named: "icons8-down-button-40") : UIImage(named: "icons8-slide-up-40")
        moreButton.setImage(icon, for: .normal)
        
        delegate?.expand(!isExpanded)
    }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onNoteSubmitted("")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.descTextField.showValid()
        return true
    }
    
    //MARK: callbacks
    func onValidTextSubmitted() {
        descTextField.text = ""
        titleTextField.text = ""
    }
    
    func onInvalidText() {
        descTextField.showInvalid()
    }
}

protocol AdjustHeightDelegate {
    func expand(_ expand: Bool)
}
