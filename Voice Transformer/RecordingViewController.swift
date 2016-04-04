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
  @IBOutlet weak var durationOfRecordingLabel: UILabel!
  
  var recorder: AVAudioRecorder!
  var timer = NSTimer()
  var timeCount = 0
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    stopButton.enabled = false
    recordingLabel.hidden = true
    durationOfRecordingLabel.text = "0 s"
    durationOfRecordingLabel.hidden = true
  }

  @IBAction func micTapped(sender: AnyObject) {
    
    durationOfRecordingLabel.hidden = false
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.countUp), userInfo: nil, repeats: true)
    recordingLabel.hidden = false
    recordingLabel.text = "Recording!"
    stopButton.enabled = true
    
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    
    do {
      try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    } catch {
      alertOnRecordFailure()
    }
    
    do {
      try recorder = AVAudioRecorder(URL: filePath!, settings: [:])
    } catch {
      alertOnRecordFailure()
    }
    
    recorder.delegate = self
    recorder.meteringEnabled = true
    recorder.prepareToRecord()
    recorder.record()
    
  }

  @IBAction func stopButtonDidTap(sender: AnyObject) {
    recorder.stop()
    timer.invalidate()
    timeCount = 0
    
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      print("save successful")
      self.performSegueWithIdentifier("ButtonTapped", sender: recorder.url)
    } else {
        print("saving error")
    }
    
  }
  
  func countUp() {
    timeCount += 1
    
    durationOfRecordingLabel.text = String(timeCount) + " s"
    
  }
  
  func alertOnRecordFailure() {
    let alertController = UIAlertController(title: "Whoops, something went wrong", message: "Please try again", preferredStyle: .Alert)
    let okToTryAgain = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    
    alertController.addAction(okToTryAgain)
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ButtonTapped")  {
      
      let playSoundVC = segue.destinationViewController as! PlaySoundsViewController
      let recordedAudioURL = sender as! NSURL
      
      playSoundVC.recordedAudioURL = recordedAudioURL
    }
 
  }
  
  
}
