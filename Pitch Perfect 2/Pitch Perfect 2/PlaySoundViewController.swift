//
//  PlaySoundViewController.swift
//  Pitch Perfect 2
//
//  Created by Christine Rehwinkel on 3/8/15.
//  Copyright (c) 2015 Christine Rehwinkel. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playSquirrel(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    // play with specified pitch
    func playAudioWithVariablePitch(pitch: Float){
        
        // stop anything from playing
        stopAndResetAudioPlayerAndEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    // play audio fast
    @IBAction func playFast(sender: UIButton) {
        stopAndResetAudioPlayerAndEngine()
        playAudioWithDifferentRate(2.0)
    }
    
    // play audio slow
    @IBAction func playSlow(sender: UIButton) {
        stopAndResetAudioPlayerAndEngine()
        playAudioWithDifferentRate(0.5)
    }

    @IBAction func stopSound(sender: UIButton) {
        stopAndResetAudioPlayerAndEngine()
    }
    
    func playAudioWithDifferentRate(rate: Float){
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stopAndResetAudioPlayerAndEngine(){
        // this functions stops audioPlayer and resets and stops audioEngine
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
