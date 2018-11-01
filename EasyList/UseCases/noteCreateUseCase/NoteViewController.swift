
import UIKit


protocol NoteControllerLogic {
    func onInvalidText()
    func onValidTextSubmitted()
}

class NoteViewController: UIViewController, NoteControllerLogic, UITextFieldDelegate  {

    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var reloadDelegate: ReloadTableDelegate?
    var interactor: NoteInteractorLogic = NoteInteractor()
    var presenter: NotePresenterLogic = NotePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do Binding
        submitButton.setTitleColor(Colours.buttons, for: .normal)
        submitButton.setTitleColor(Colours.secondary, for: .highlighted)
        interactor.presenter = presenter
        presenter.controller = self
        textField.delegate = self
        
        // Present Something
        textField.placeholder = presenter.getFieldPlaceholder()
    }
    
    @IBAction func onNoteSubmitted(_ sender: Any) {
        interactor.processText(textField.text)
        reloadDelegate?.shouldReloadTable()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.textField.showValid()
        return true
    }
    
    
    //MARK: presenter callbacks
    func onValidTextSubmitted() {
        textField.text = ""
    }
    
    func onInvalidText() {
        textField.showInvalid()
    }
}
