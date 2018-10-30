
import UIKit

protocol NoteInputPresenterLogic {
    
}

class NoteViewController: KeyboardViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var interactor: NoteInteractorLogic = NoteInteractor()
    var presenter: NotePresenterLogic = NotePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = presenter.getFieldPlaceholder()
        submitButton.addTarget(self, action: #selector(onNoteSubmited), for: .touchUpInside)
    }
    
    @objc func onNoteSubmited(_ sender: Any) {
        if let text = textField.text {
            interactor.processText(text)
        }
    }
}
