//
//  statusBarViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 17.10.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import Reachability
import CoreTelephony
import AVFoundation

class statusBarViewController: UIViewController {
    let reachability = Reachability()!
    
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    let emptyString = String() // Do nothing
    var batteryState = UIDevice.current.batteryState
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    
    
    
    @IBOutlet var statusBarBackground: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var signalStrenght: UIImageView!
    @IBOutlet var connectivyIcon: UIImageView!
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        configUI()
        let batteryLevel = UIDevice.current.batteryLevel*100
        MyBattery = batteryLevel

        
        
        //Clock
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        //Network Type
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkNetwork), userInfo: nil, repeats: true)
        
        //Battery
        batteryStateDidChange()

    }
    
    
    
    
    
    
    func configUI() {
    }
    
    
    
    
    
    
    @objc func checkNetwork() {
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        let carrierName = carrier?.carrierName
        print(carrierName!)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func updateBatteryState() {

        
        var PbatteryLevel: Float {
            return UIDevice.current.batteryLevel
        }
                
        
        
        let status = UIDevice.current.batteryState
        switch status {
            
        case .full:
            print("Battery Full")
            switchBattery()
        case .unplugged:
            print("Battery unplugged")
            switchBattery()
            
        case .charging:
            print("Battery charging")
            switchBattery()
            
            if let asset = NSDataAsset(name:"charging"){
                
                do {
                    player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                    player.play()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
            
        case .unknown:
            print("Battery unknown")
            
        }
        
    }
    
    
    
    
    
    
    
    
    func batteryStateDidChange() {
        self.updateBatteryState()
    }
    
    
    
    
    
    
    
    
    func switchBattery() {
        
        
        switch MyBattery {
            
        case 91.0...100.0:
            battery.image = UIImage(named: "100.png")

            
        case 81.0..<90.0:
            battery.image = UIImage(named: "90.png")
            
            
        case 71.0..<80.0:
            battery.image = UIImage(named: "80.png")
            
            
        case 61.0..<70.0:
            battery.image = UIImage(named: "70.png")
            
            
        case 51.0..<60.0:
            battery.image = UIImage(named: "60.png")
            
            
        case 41.0..<50.0:
            battery.image = UIImage(named: "50.png")
            
            
        case 31.0..<40.0:
            battery.image = UIImage(named: "40.png")
            
            
        case 21.0..<30.0:
            battery.image = UIImage(named: "30.png")
            
            
        case 16.0..<20.0:
            battery.image = UIImage(named: "20.png")
            
            
        case 11.0..<15.0:
            battery.image = UIImage(named: "15.png")
            
            
        case 6.0..<10.0:
            battery.image = UIImage(named: "10.png")
            
            
        case 0.0..<5.0:
            battery.image = UIImage(named: "5.png")

            
            
            
            
        default:
            battery.image = UIImage(named: "0.png")
            
            
            
        }
        
        
        
    }
    
    
}


extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 1
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
