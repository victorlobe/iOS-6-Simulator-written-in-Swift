//
//  lockscreenDeactivatedViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 24.09.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class lockscreenDeactivatedViewController: UIViewController {
    @IBOutlet var unlockBtnOut: UIButton!
    
    var player: AVAudioPlayer = AVAudioPlayer()
    let playerSession = MPMusicPlayerController.systemMusicPlayer

    
    var MyBattery: Float = 0.0
    var timer = Timer()
    let emptyString = String() // Do nothing
    var batteryState = UIDevice.current.batteryState
    var countdownSeconds = 0
    
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var unlockSlider: UISlider!
    @IBOutlet var entsperrenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unlockSlider.setThumbImage(UIImage(named: "unlockthumb"), for: UIControlState.normal)
        entsperrenLabel.startShimmering()

        countdownSeconds = 60
        let activateA = DispatchTime.now() + 60 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: activateA) {
            self.performSegue(withIdentifier: "activate", sender: self)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        

        
    }
    
    @objc func updateTimer() {
        countdownSeconds -= 1
        countdownLabel.text = "In 1 Minute erneut versuchen"
    }
    
    
    

}
