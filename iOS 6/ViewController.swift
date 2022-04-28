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
    
    
    
    
    
    var emptyString = String()
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    var batteryState = UIDevice.current.batteryState
    var isFullScreen = false
    var isFullScreenHelp = false
    var prevFrame = CGRect()
    var prevFrameHelp = CGRect()
    let launchScreenImageView = UIImageView()
    var launchscreenVisible = false
    
    @IBOutlet var wallpaperImageView: UIImageView!
    
    @IBAction func safariBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenSafari")
        UIView.animate(withDuration: 0.4) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "homeToSafari", sender: self)
        }
        
    }
    
    @IBAction func mailBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenMail")
        UIView.animate(withDuration: 0.4) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "homeToMail", sender: self)
        }
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenCamera")
        UIView.animate(withDuration: 0.4) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "homeToCamera", sender: self)
        }
    }
    
    @IBAction func phoneBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenPhone")
        UIView.animate(withDuration: 0.4) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "homeToPhone", sender: self)
        }
    }
    
    @IBAction func notesBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenNotes")
        UIView.animate(withDuration: 0.4) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "homeToNotes", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchScreenImageView.frame = CGRect(x: wallpaperImageView.frame.origin.x, y: wallpaperImageView.frame.origin.y, width: wallpaperImageView.frame.width, height: wallpaperImageView.frame.height)
        launchScreenImageView.contentMode = .scaleAspectFit
        view.addSubview(launchScreenImageView)
        launchScreenImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        launchscreenVisible = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if launchscreenVisible == true {
            UIView.animate(withDuration: 0.3) {
                self.launchScreenImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
            self.launchscreenVisible = false
        }
    }
        
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
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
    
    
}




