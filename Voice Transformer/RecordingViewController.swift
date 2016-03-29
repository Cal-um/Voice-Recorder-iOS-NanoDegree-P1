//
//  ViewController.swift
//  Voice Transformer
//
//  Created by Calum Harris on 22/03/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {

  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    stopButton.enabled = false
  }

  @IBAction func micTapped(sender: AnyObject) {
    
    recordingLabel.hidden = false
    stopButton.enabled = true
  }

  @IBAction func stopButtonTapped(sender: AnyObject) {
    performSegueWithIdentifier("stopButtonTapped", sender: nil)
    
  }
  
  func recordVoice() {
    
    var recorder = AVAudioRecorder()
    
    
  }
  
  

}

