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
        
        recorder.askPermissions { (result: RecordingResult) in
            switch result {
                
                case RecordingResult.NOTALLOUD:
                    print("RECORD: didn't alloud open mic")

                    self.recordButton.titleLabel?.text = "You Not alloud recording voice"
                
                case RecordingResult.ALLOUD:
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

            recorder.startRecording(id: "hello")
        }
    }
    
    @IBAction func onPlaybackTapped(_ sender: Any) {
        
        recorder.playBack(id: "hello")
    }
    
    var isRecording = false
    
    // MARK: recorder delegates
    
    func onRecordingFailure() {
    
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
