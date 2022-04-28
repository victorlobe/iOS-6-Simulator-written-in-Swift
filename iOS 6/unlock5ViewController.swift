//
//  unlock5ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 09.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation

class unlock5ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()

    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    
    
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    let emptyString = String() // Do nothing
    
    override func viewDidLoad() {
        
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "iphone_unlock", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        }
        catch
        {
            //ERROR
        }
        
        player.play()
        
        
        
    
        
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        dateLabel.text = "\(formatter.string(from: date))"
        
        
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
        
        print("code input received 2")

        
    }
    
    
    
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        //timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "home", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "home") {
            
            
            
            print("Segue Performed")
            
        }
        
    }
    
}






