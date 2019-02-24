//
//  RecordViewController.swift
//  Note Tracker
//
//  Created by Aristeidis Panagiotopoulos on 23/02/2019.
//  Copyright © 2019 arisPanagiotopoulos. All rights reserved.
//

import UIKit


class RecordViewController: UIViewController, RecorderDelegate {
 
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playBackButton: UIButton!
    
    var recorder = Recorder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorder.delegate = self
        
        recorder.startSession { (result: RecordingResult) in
            switch result {
            
                case RecordingResult.FAILURE:
                    print("RECORD: failed start session")
                    self.onRecordingFailure()
                
                case RecordingResult.NOTALLOUD:
                    print("RECORD: didn't alloud open mic")

                    self.recordButton.titleLabel?.text = "You Not alloud recording voice"
                
                case RecordingResult.SUCCESS:
                    print("RECORD: opened session successfully")

                    break
            }
        }
    }
    
    @IBAction func onRecordTapped(_ sender: Any) {
        
        if isRecording {
            print("RECORD: stoprecording")

            recorder.stopRecording()
        } else {
            print("RECORD: start recording")

            recorder.startRecording()
        }
    }
    
    @IBAction func onPlaybackTapped(_ sender: Any) {
        
        recorder.playBack()
    }
    
    var isRecording = false
    
    // MARK: recorder delegates
    
    func onRecordingFailure() {
        DispatchQueue.main.async {
            self.recordButton.titleLabel?.text = "FAILURE RECORDING"
        }
    }
    
    func onStartRecording() {
        DispatchQueue.main.async {
            self.recordButton.titleLabel?.text = "RECORDING"
            self.isRecording = true
        }
    }
    
    func onPlayBackError() {
        DispatchQueue.main.async {
            self.playBackButton.titleLabel?.text = "FAILURE PLAYBACK"
        }
    }
}
