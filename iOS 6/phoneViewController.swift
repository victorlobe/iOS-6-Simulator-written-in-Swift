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
        
        UserDefaults.standard.set(numberLabel.text, forKey: "callSessionNumber")
            self.performSegue(withIdentifier: "phoneToCall", sender: self)
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
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
        numberLabel.text = String(numberLabel.text!.dropLast())
    }
    
    
    @IBAction func addToContacts(_ sender: Any) {
        let pasteboardString: String? = UIPasteboard.general.string
        if let theString = pasteboardString {
            numberLabel.text = theString
        }
    }
    
    var emptyString = String()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)".components(separatedBy: .whitespacesAndNewlines).joined()) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
}


