//
//  ViewController.swift
//  Sound
//
//  Created by George Mason on 5/30/17.
//  Copyright © 2017 Griffin Mason. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    @IBOutlet weak var RecordButton: UIButton!
    
    @IBOutlet weak var StopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingUp()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    var soundRecorder : AVAudioRecorder!
    var soundPlay : AVAudioPlayer!
    
    var recording = "record.m4a"

    let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
    
    func getCacheDirectory() -> String {
        let cache = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return cache[0]
    }
    
    func getURL() -> NSURL {
        let writePath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(recording)
        return writePath! as NSURL
    }
    
    func settingUp() {
        let recordSettings = [AVFormatIDKey : kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String: Any]
    
        soundRecorder = try! AVAudioRecorder(url: getURL() as URL, settings: recordSettings)
        soundRecorder.delegate = self
        soundRecorder.prepareToRecord()
        }
    
    func preparePlayer() {
        soundPlay = try! AVAudioPlayer(contentsOf: getURL() as URL)
        soundPlay.prepareToPlay()
        soundPlay.volume = 10.0
        }

    
    
    @IBAction func recSound(_ sender: UIButton) {
        RecordButton.isEnabled = false
        soundRecorder.record()
    }

    @IBAction func stop(_ sender: UIButton) {
        soundRecorder.stop()
        preparePlayer()
        soundPlay.play()
    }
}


