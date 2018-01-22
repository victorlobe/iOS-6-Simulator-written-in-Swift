//
//  singleCodeViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 18.08.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import AVFoundation

class singleCodeViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var deactivateInt = 0
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!

    @IBOutlet var statusbarView: UIView!
    @IBOutlet var smallPrompt: UILabel!
    @IBOutlet var prompt: UILabel!
    @IBOutlet var topBar: UIImageView!
    @IBOutlet var numberLabel: UILabel!
    let pulseAnimation = CABasicAnimation(keyPath: "opacity")

    
    @IBAction func deleteBtn(_ sender: Any) {
        numberLabel.text = ""
        dotA.isHidden = true
        dotB.isHidden = true
        dotC.isHidden = true
        dotD.isHidden = true
        
    }
    
    
    @IBAction func one(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "1"
        statusCheck()
        
    }
    @IBAction func two(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "2"
        statusCheck()
        
        
    }
    
    @IBAction func three(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "3"
        statusCheck()
        
    }
    
    
    @IBAction func four(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "4"
        statusCheck()
        
    }
    @IBAction func five(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "5"
        statusCheck()
        
    }
    
    @IBAction func six(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "6"
        statusCheck()
        
    }
    
    @IBAction func seven(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "7"
        statusCheck()
        
    }
    @IBAction func eight(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "8"
        statusCheck()
        
    }
    
    @IBAction func nine(_ sender: Any) {
        
        numberLabel.text = (numberLabel.text ?? "") + "9"
        statusCheck()
    }
    
    @IBAction func zero(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "0"
        statusCheck()
        
    }
    
    @IBOutlet var dotA: UILabel!
    @IBOutlet var dotB: UILabel!
    @IBOutlet var dotC: UILabel!
    @IBOutlet var dotD: UILabel!
    
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    let emptyString = String() // Do nothing
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBar()
        
        
    }
    
    
    func statusCheck() {
        
        
        
        var numChars = numberLabel.text?.characters.count ?? 0
        numChars = numberLabel.text?.characters.count ?? 0
        
        
        
        if numChars == 1 {
            dotA.isHidden = false
            
        }
        if numChars == 2 {
            dotB.isHidden = false
            
            
        }
        if numChars == 3 {
            dotC.isHidden = false
            
            
        }
        
        if numChars == 4 {
            dotD.isHidden = false
            
            codeVerification()
            
            
        }
    }
    
    
    
    
    func codeVerification() {
        
        if numberLabel.text == "9032" {
            
            self.performSegue(withIdentifier: "singleCodePassed", sender: self)
            unlockSound()
            
            
        } else {
            
            deactivateInt += 1
            
            checkDeactivated()
            
            dotD.isHidden = false
            let when = DispatchTime.now() + 0.15
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.numberLabel.text = ""
                self.dotA.isHidden = true
                self.dotB.isHidden = true
                self.dotC.isHidden = true
                self.dotD.isHidden = true
            }
            
            topBar.image = UIImage(named: "wrongCodeBarTexture")
            
            statusbarView.backgroundColor = UIColor(red:0.58, green:0.22, blue:0.22, alpha:1.0)
            
            
            smallPrompt.layer.opacity = 0
            pulseAnimation.duration = 0.1
            pulseAnimation.fromValue = 0
            pulseAnimation.toValue = 1
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = 2
            self.smallPrompt.layer.add(pulseAnimation, forKey: nil)
            smallPrompt.layer.opacity = 1
            
            prompt.text = "Falscher Code"
            
            smallPrompt.text = "Wiederholen"
            smallPrompt.isHidden = false
           

            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            

            
        }
        
    }
    
    @objc func checkDeactivated() {
        if deactivateInt == 6 {
            self.performSegue(withIdentifier: "deactivatePhone", sender: self)
            
        }
        
        
        
    }
    
    
    func statusBar() {
        
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
    
    func unlockSound() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "iphone_unlock", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        }
        catch
        {
            print("iphone_unlock (ofType: ´mp3´) could not be played")
        }
        
        player.play()
        
        
        
    }
    
        
        
        
    }
    

    
    


