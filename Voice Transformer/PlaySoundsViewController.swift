//
//  PlaySoundsViewController.swift
//  Voice Transformer
//
//  Created by Calum Harris on 29/03/2016.
//  Copyright © 2016 Calum Harris. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  var recordedAudioURL: NSURL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: NSTimer!
  
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var vaderButton: UIButton!
  @IBOutlet weak var squirrelButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var parrotButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
  enum ButtonType: Int { case Rabbit, Snail, Vader, Squirrel, Reverb, Parrot }
  
  
  @IBAction func playSound(sender: AnyObject) {
    
    switch(ButtonType(rawValue: sender.tag)!) {
      
    case .Rabbit:
      playSound(rate: 1.5)
    case .Snail:
      playSound(rate: 0.5)
    case .Vader:
      playSound(pitch: -1000)
    case .Squirrel:
      playSound(pitch: 1000)
    case .Reverb:
      playSound(reverb: true)
    case .Parrot:
      playSound(echo: true)
    }
    configureUI(.Playing)
  }
  
  @IBAction func stopSound(sender: AnyObject) {
    stopAudio()
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
  }
  
  override func viewWillAppear(animated: Bool) {
    configureUI(.NotPlaying)
  }
  
  override func viewWillDisappear(animated: Bool) {
    stopAudio()
  }
  
}