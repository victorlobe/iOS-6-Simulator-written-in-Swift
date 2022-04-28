//
//  tttlViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 11.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class tttlViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!    
    
    
    @IBOutlet var trafficLight: UIImageView!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var startStop: UIButton!
    
    var timer = Timer()
    var scoreTimer = Timer()
    
    var timerInt = 0
    var scoreInt = 0
    
    var MyBattery: Float = 0.0
    var clock = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clock = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
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
        
        
        
        
        
        
        scoreInt = 0
        counterLabel.text = String(scoreInt)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartStop(_ sender: Any) {
        
        if scoreInt == 0 {
            
            timerInt = 3
            
            trafficLight.image = UIImage(named: "TrafficLight")
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tttlViewController.updateCounter), userInfo: nil, repeats: true)
            
            startStop.isEnabled = false
            startStop.setTitle("", for: [])
            
            scoreInt = 0
            counterLabel.text = String(scoreInt)
            
        } else {
            
            scoreTimer.invalidate()
            
            
        }
        
        if timerInt == 0 {
            
            scoreInt = 0
            startStop.setTitle(NSLocalizedString("Restart", comment: "restart"), for: [])
            
            
            
            
        }
        
        
        
    }
    
    @objc func updateCounter() {
        
        timerInt -= 1
        
        if timerInt == 2 {
            
            trafficLight.image = UIImage(named: "TrafficLight3")
            
        } else if timerInt == 1 {
            
            trafficLight.image = UIImage(named: "TrafficLight2")
            
            startStop.setTitle(NSLocalizedString("Stop", comment: "stop"), for: [])
            
        } else if timerInt == 0 {
            trafficLight.image = UIImage(named: "TrafficLight1")
            
            timer.invalidate()
            
            startStop.isEnabled = true
            
            scoreTimer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(tttlViewController.updateScoreTimer), userInfo: nil, repeats: true)
            
            
            
            
        }
        
    }
    
    @objc func updateScoreTimer() {
        
        scoreInt += 1
        counterLabel.text = String(scoreInt)
        
        
        
    }
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    

    
    
    
    
    
}


