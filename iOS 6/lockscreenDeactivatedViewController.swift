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
    

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var decTimeLabel: UILabel!
    @IBOutlet var networkImage: UIImageView!
    
    @IBOutlet var wallpaper: UIImageView!
    @IBOutlet var lsBattery: UIImageView!
    @IBOutlet var statusBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activateA = DispatchTime.now() + 60 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: activateA) {
            self.performSegue(withIdentifier: "activate", sender: self)
            
            self.configureUI()
            self.getCurrentMetadata()
        }


        
 
        statusBarView.backgroundColor = UIColor(red:0.58, green:0.22, blue:0.22, alpha:1.0)
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        let batteryLevel = UIDevice.current.batteryLevel*100
        
        
        
        print ("My Battery:\(batteryLevel)")
        
        
        MyBattery = batteryLevel
        
        
        switch MyBattery {
            
        case 90.0...100.0:
            battery.image = UIImage(named: "100.png")
            
        case 80.0..<90.0:
            battery.image = UIImage(named: "90.png")
            
        case 70.0..<80.0:
            battery.image = UIImage(named: "80.png")
            
        case 60.0..<70.0:
            battery.image = UIImage(named: "70.png")
            
        case 50.0..<60.0:
            battery.image = UIImage(named: "60.png")
            
        case 40.0..<50.0:
            battery.image = UIImage(named: "50.png")
            
        case 30.0..<40.0:
            battery.image = UIImage(named: "40.png")
            
        case 20.0..<30.0:
            battery.image = UIImage(named: "30.png")
            
        case 15.0..<20.0:
            battery.image = UIImage(named: "20.png")
            
        case 10.0..<15.0:
            battery.image = UIImage(named: "15.png")
            
        case 5.0..<10.0:
            battery.image = UIImage(named: "10.png")
            
        case 0.0..<5.0:
            battery.image = UIImage(named: "5.png")
            
            
            
        default:
            battery.image = UIImage(named: "0.png")
            
            
            
        }
        
        

        
    }
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    
    
    
    
    
    
    
    @objc func getCurrentMetadata() {
        if let mediaItem = playerSession().nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
            
           
            print("\(title) on \(albumTitle) by \(artist)")
        }
    }
    
    
    @objc func configureUI() {
        if playerSession().playbackState == .playing {
            
            
        } else {
            
            
        }
        
        
        
        
        
    }
    
    
    

}
