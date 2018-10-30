
import UIKit


protocol NoteControllerLogic {
    func onInvalidText()
    func onValidText()
}

class NoteViewController: KeyboardViewController, NoteControllerLogic {

    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var interactor: NoteInteractorLogic = NoteInteractor()
    var presenter: NotePresenterLogic = NotePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do Binding
        
        interactor.presenter = presenter
        presenter.controller = self
        
        // Present Something
        textField.placeholder = presenter.getFieldPlaceholder()
    }
    
    @IBAction func onNoteSubmitted(_ sender: Any) {
        interactor.processText(textField.text)
    }
    
    
    func onValidText() {
        //
    }
    
    func onInvalidText() {
        //
    }
}
