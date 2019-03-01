
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
    
    var recordPath: String?
    
    var canRecord = true
    
    var recordingReady = false
    
    var recorder: RecorderProtocol = Recorder()
    
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
    
    @IBAction func exit(_ sender: Any) {
        if canRecord, recordPath != nil {
            recorder.stopRecording()
            recorder.deleteRecording(id: recordPath!)
            DispatchQueue.main.async {
                self.descTextField.text = ""
            }
        }
    }
    
    @IBAction func onRecordingStarted(_ sender: Any) {
        if canRecord {
            self.recordPath = Date().toString()
            self.recorder.startRecording(id: "hello.m4p")
            DispatchQueue.main.async {
                self.descTextField.text = "Recording..."
            }
        }
    }
    
    @IBAction func onNoteSubmitted(_ sender: Any) {

        if recorder.state == .recordingStarted {
            stopRecording()
        } else {
        
            let note = NoteModel(title: titleTextField.text ?? "", text: descTextField?.text ?? "")
        
            if recordingReady {
                note.pathToRecording = recordPath
                processRecording()
            }
            
            interactor?.processNewNote(note)
            onTextIsInvalid()

            descTextField.text = ""
            titleTextField.text = ""
            
            delegate?.reload()
        }
    }
    
    private func stopRecording() {
        
        recordingReady = true
        recorder.stopRecording()
        DispatchQueue.main.async {
            self.descTextField.text = "Recording ready."
            self.descTextField.isEnabled = false
        }
        onTextIsValid()
    }
    
    private func processRecording() {
        recordPath = nil
        recordingReady = false
        self.descTextField.isEnabled = true
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
        canRecord = false
        submitButton.setImage(UIImage.init(imageLiteralResourceName: "icons8-plus-40"), for: .normal)
    }
    
    func onTextIsInvalid() {
        canRecord = true
        submitButton.setImage(UIImage.init(imageLiteralResourceName: "icons8-play-record-40"), for: .normal)
    }
}
