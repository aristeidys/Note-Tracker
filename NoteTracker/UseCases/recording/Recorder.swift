//
//  Recorder.swift
//  Note Tracker
//
//  Created by Aristeidis Panagiotopoulos on 24/02/2019.
//  Copyright © 2019 arisPanagiotopoulos. All rights reserved.
//

import AVFoundation
import UIKit

protocol RecorderDelegate {
    
    func onRecordingFailure()
    
    func onStartRecording()
    
    func onPlayBackError()
}


protocol RecorderProtocol {
    /// starts recording session
    ///
    /// - Parameter completion with FAILURE, SUCCESS or NOTALLOUD
    func askPermissions(_ completion: @escaping RecordingCompletion)
    
    /// starts recording
    func startRecording(id: String)
    
    // stops recording
    func stopRecording()
    
    // Plays the recording back
    func playBack(id: String)
    
    // Deletes recording
    func deleteRecording(id: String)
    
    var state: RecordingState { get set }
}

class Recorder: NSObject, AVAudioRecorderDelegate, RecorderProtocol {
    
    var recorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    var delegate: RecorderDelegate?
    let recordingSession = AVAudioSession.sharedInstance()
    var state: RecordingState = .recordingStoped

    
    override init() {
        super.init()
        
        askPermissions {(result: RecordingResult) in
            // TODO: empty
        }
    }
    
    public func askPermissions(_ completion: @escaping RecordingCompletion) {
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)

            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        completion(.ALLOUD)
                        print("RECORD: Permisions Granted")
                    } else {
                        completion(.NOTALLOUD)
                        print("RECORD: No Permissions Granted")
                    }
                }
            }
        } catch {
            print("RECORD: Session Start Error")
        }
    }
    
    
    public func startRecording(id: String) {
        
        let audioURL = recordingURL(id: id)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        do {
            recorder = try AVAudioRecorder(url: audioURL, settings: settings)
            recorder.delegate = self
            recorder.record()
            delegate?.onStartRecording()
            state = .recordingStarted
            print("RECORD: Recording Started")
        } catch {
            stopRecording()
            delegate?.onRecordingFailure()
            print("RECORD: Recording Failure")
        }
    }
    
    
    public func stopRecording() {
        state = .recordingStoped
        recorder.stop()
        recorder = nil
        print("RECORD: Recording Stopped")
    }

    
    public func playBack(id: String) {
        
        let audioFilePath = recordingURL(id: id)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.play()
            print("RECORD: PlayBack Started")
        } catch let error {
            delegate?.onPlayBackError()
            print("RECORD: PlayBack Error \(error)")
        }
        
    }

    // MARK: PRIVATE METHODS
    
    private func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            // TODO: notify user
            stopRecording()
            delegate?.onRecordingFailure()
            print("RECORD: Recording Failure")
        }
    }
    
    private func recordingURL(id: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(id)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public func deleteRecording(id: String) {
        let url = getDocumentsDirectory().appendingPathComponent(id)
        
        if url.isFileURL {
            do {
                try FileManager.default.removeItem(at: url)
                print("RECORD: delete Recording \(url.absoluteString)")
            } catch {
                print("RECORD: Couldn't delete \(url.absoluteString)")
            }
        } else {
            print("RECORD: no file \(url.absoluteString)")
        }
    }
}


enum RecordingResult {
    case NOTALLOUD
    case ALLOUD
}

enum RecordingState {
    case recordingStarted
    case recordingStoped
}

typealias RecordingCompletion =  (RecordingResult) -> Void
