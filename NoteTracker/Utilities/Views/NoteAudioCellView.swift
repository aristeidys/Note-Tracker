import UIKit
import DateHelper

class NoteAudioCellView: UITableViewCell, NoteCellProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var skipToStartButton: UIImageView!
    @IBOutlet weak var soundControlButton: UIButton!
    
    var recording: String?
    
    func setupView(_ entity: NoteModel?) {
        titleLabel.text = entity?.title
        dateLabel.text = entity?.editedDate?.toStringWithRelativeTime()
        
        dateLabel.textColor = .black
        
        titleLabel.font = Fonts.bigBold
        dateLabel.font = Fonts.secondary
        
        recording = entity?.pathToRecording
    }
    
    @IBAction func onSoundControlTapped(_ sender: Any) {
        let recorder = Recorder()
        
        if let recordingExisting = recording {
            recorder.playBack(id: "hello.m4p")
        }
    }
    
    @IBAction func onSkipToStartTapped(_ sender: Any) {
        
    }
}
