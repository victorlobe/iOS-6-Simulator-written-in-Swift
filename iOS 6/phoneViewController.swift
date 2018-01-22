//
//  phoneViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 30.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation

class phoneViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()

    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBAction func one(_ sender: Any) {
        
        numberLabel.text = (numberLabel.text ?? "") + "1"
        if let asset = NSDataAsset(name:"dtmf-1"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func two(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "2"
        if let asset = NSDataAsset(name:"dtmf-2"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func three(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "3"
        if let asset = NSDataAsset(name:"dtmf-3"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func four(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "4"
        if let asset = NSDataAsset(name:"dtmf-4"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func five(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "5"
        if let asset = NSDataAsset(name:"dtmf-5"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func six(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "6"
        if let asset = NSDataAsset(name:"dtmf-6"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func seven(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "7"
        if let asset = NSDataAsset(name:"dtmf-7"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func eight(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "8"
        if let asset = NSDataAsset(name:"dtmf-8"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func nine(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "9"
        if let asset = NSDataAsset(name:"dtmf-9"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func null(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "0"
        if let asset = NSDataAsset(name:"dtmf-0"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func call(_ sender: Any) {
        
        callNumber(phoneNumber: numberLabel.text!)
        
    }
    
    @IBAction func star(_ sender: Any) {
        
           numberLabel.text = (numberLabel.text ?? "") + "*"
        if let asset = NSDataAsset(name:"dtmf-star"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    @IBAction func hashtag(_ sender: Any) {
        
        numberLabel.text = (numberLabel.text ?? "") + "#"
        if let asset = NSDataAsset(name:"dtmf-hashtag"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                player.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        numberLabel.text = ""
        
        
    }
    
    
    @IBAction func addToContacts(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func voicemail(_ sender: Any) {
        
                callNumber(phoneNumber: "9911")
        
        
    }
    
    
    
    
    
    var emptyString = String()
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    
    
    
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
        
    }
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    

    
        
        numberLabel.text = (numberLabel.text ?? "") + ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
}


