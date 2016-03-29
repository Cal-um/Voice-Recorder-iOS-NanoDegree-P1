//
//  ViewController.swift
//  Voice Transformer
//
//  Created by Calum Harris on 22/03/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate {

  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  
  var recorder: AVAudioRecorder!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    stopButton.enabled = false
  }

  @IBAction func micTapped(sender: AnyObject) {
    
    recordingLabel.hidden = false
    recordingLabel.text = "Recording!"
    stopButton.enabled = true
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    
    try! recorder = AVAudioRecorder(URL: filePath!, settings: [:])
    recorder.delegate = self
    recorder.meteringEnabled = true
    recorder.prepareToRecord()
    recorder.record()
    
  }

  @IBAction func stopButtonDidTap(sender: AnyObject) {
    recorder.stop()
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      print("save successful")
      self.performSegueWithIdentifier("ButtonTapped", sender: recorder.url)
    } else {
        print("saving error")
    }
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ButtonTapped")  {
      
      let playSoundVC = segue.destinationViewController as! PlaySoundsViewController
      
      let recordedAudioURL = sender as! NSURL
      playSoundVC.recordedAudioURL = recordedAudioURL
    }
  }
  
  
}
