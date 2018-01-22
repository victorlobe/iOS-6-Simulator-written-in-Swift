//
//  boot9ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 08.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class boot9ViewController: UIViewController {

    var emptyString = String()
    var batteryState = UIDevice.current.batteryState

    @IBOutlet var batteryMessageB: UILabel!
    @IBOutlet var batteryMessageC: UILabel!
    @IBOutlet var batteryFloat: UILabel!
    
    @IBOutlet var spinningIndicator: UIActivityIndicatorView!
    @IBOutlet var batteryDetector: UILabel!
    @IBOutlet var timeanddate: UILabel!
    @IBOutlet var battery: UILabel!
    
    
    var MyBattery: Float = 0.0
    var error = false
    
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerUpdater()
        
        let batteryLevel = UIDevice.current.batteryLevel*100

        battery.text = ("My Battery:\(batteryLevel)")
        
        MyBattery = batteryLevel

        
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
                timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateBatteryState), userInfo: nil, repeats: true)
        

        
    }
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .full
        
        
        timeanddate.text = timeFormatter.string(from: NSDate() as Date)
        
        
    }
    
    func timeToMoveOn() {
        if error == false {
        self.performSegue(withIdentifier: "tolock", sender: self)
        } else {}
    }
    
    
    func updateBatteryState() {
        
        let status = UIDevice.current.batteryState
        switch status {
            
        case .full:
            batteryDetector.text = "batteryState = .full"

            
        case .unplugged:
            
            batteryDetector.text = "batteryState = .unplugged"

            
            Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)

            
        case .charging:

            batteryDetector.text = "batteryState = .charging"
            
            
            Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
            
            
        case .unknown:
            error = true
            batteryDetector.textColor = UIColor.red
            batteryDetector.text = "batteryState = .unknown"
        spinningIndicator.stopAnimating()
            batteryFloat.textColor = UIColor.red
            batteryMessageB.textColor = UIColor.red
            batteryMessageC.textColor = UIColor.red
            
            batteryFloat.text = "var MyBattery: NOT DETECTED"
            batteryMessageB.text = "let batteryLevel = UIDevice.current.?[UNKNOWN BATTERY STATE]"
            batteryMessageC.text = "--"
            
            timeanddate.textColor = UIColor.red
            
            
            timeanddate.text = "<iOS_6.bootErrorViewController: 0x123606260> on <iOS_6.boot9ViewController: 0x119d50c40> whose view is not in the window hierarchy!"
            
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {

                self.performSegue(withIdentifier: "bootError", sender: Any)
            
                
            }
            
            
        }
        
    }
    
    func batteryStateDidChange() {
        self.updateBatteryState()
    }
    
    func timerUpdater() {
            timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}

