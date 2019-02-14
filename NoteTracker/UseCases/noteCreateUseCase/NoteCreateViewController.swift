
import UIKit


protocol NoteControllerLogic {
    func onInvalidText()
    func onValidTextSubmitted()
}

class NoteCreateViewController: UIViewController, NoteControllerLogic, UITextFieldDelegate  {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var reloadDelegate: ReloadDelegate?
    var interactor: NoteCreateInteractorLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do Binding
        submitButton.setTitleColor(Colours.buttons, for: .normal)
        submitButton.setTitleColor(Colours.secondary, for: .highlighted)
        textField.delegate = self
        interactor = NoteCreateInteractor(self)
        
        // Present Something
        textField.placeholder = "Create a Note..."
    }
    
    @IBAction func onNoteSubmitted(_ sender: Any) {
        let note = NoteModel(title: "", text: textField?.text ?? "")
        interactor?.processNewNote(note)
        reloadDelegate?.reload()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.textField.showValid()
        return true
    }
    
    
    //MARK: callbacks
    func onValidTextSubmitted() {
        textField.text = ""
    }
    
    func onInvalidText() {
        textField.showInvalid()
    }
}
