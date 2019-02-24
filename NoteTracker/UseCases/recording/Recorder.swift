//
//  Recorder.swift
//  Note Tracker
//
//  Created by Aristeidis Panagiotopoulos on 24/02/2019.
//  Copyright © 2019 arisPanagiotopoulos. All rights reserved.
//

import AVFoundation


protocol RecorderDelegate {
    
    func onRecordingFailure()
    
    func onStartRecording()
    
    func onPlayBackError()
}


protocol RecorderProtocol {
    /// starts recording session
    ///
    /// - Parameter completion with FAILURE, SUCCESS or NOTALLOUD
    func startSession(_ completion: @escaping RecordingCompletion)
    
    /// starts recording
    func startRecording()
    
    // stops recording
    func finishRecording()
    
    // Plays the recording back
    func playBack()
}

class Recorder: NSObject, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var recorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    var delegate: RecorderDelegate?
    
    
    public func startSession(_ completion: @escaping RecordingCompletion) {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        completion(.SUCCESS)
                        print("RECORD: Session Started")
                    } else {
                        completion(.NOTALLOUD)
                        print("RECORD: No Permissions")
                    }
                }
            }
        } catch {
            completion(.FAILURE)
            print("RECORD: Session Start Error")
        }
    }
    
    
    public func startRecording() {
        
        let audioURL = recordingURL()
        
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
            print("RECORD: Recording Started")
        } catch {
            stopRecording()
            delegate?.onRecordingFailure()
            print("RECORD: Recording Failure")
        }
    }
    
    
    public func stopRecording() {

        recorder.stop()
        recorder = nil
        print("RECORD: Recording Stopped")
    }

    
    public func playBack() {
        
        let audioFilePath = recordingURL()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.play()
            print("RECORD: PlayBack Started")
        } catch {
            delegate?.onPlayBackError()
            print("RECORD: PlayBack Error")
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
    
    private func recordingURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}


enum RecordingResult {
    case FAILURE
    case NOTALLOUD
    case SUCCESS
}

typealias RecordingCompletion =  (RecordingResult) -> Void
