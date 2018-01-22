//
//  ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 07.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var batteryPercentage: UILabel!
    
    
    
    
    var emptyString = String()
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    var batteryState = UIDevice.current.batteryState

        
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
                
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
        
         Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(updateBatteryState), userInfo: nil, repeats: false)
                
    
    }
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    @IBAction func lock(_ sender: Any) {
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "iphone_lock_screen", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        }
        catch
        {
            //ERROR
        }
        
        player.play()
        
        
        
        
        
    }
    
    func updateBatteryState() {
        
        let status = UIDevice.current.batteryState
        switch status {
            
        case .full:
            
            print("full")
            
        case .unplugged:
            
            
            
            print("unplugged")
            
        case .charging:
            
            //battery.image = #imageLiteral(resourceName: "batteryCharging")
            
            print("charging")
            
        case .unknown:
            print("unknown")
            
        }
        
    }
    
    func batteryStateDidChange() {
        self.updateBatteryState()
    }
    
    
}




