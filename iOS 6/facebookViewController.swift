//
//  facebookViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 28.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class facebookViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var batteryPercentage: UILabel!
    
    
    
    @IBAction func newsfeed(_ sender: Any) {
        
        let url = "https://m.facebook.com"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
    }
    
    
    @IBAction func friends(_ sender: Any) {
        
        let url = "https://m.facebook.com/friends/requests/?fcref=jwl"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
    }
    
    @IBAction func messages(_ sender: Any) {
        
        let url = "https://m.facebook.com/messages/t/"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
    }
    
    @IBAction func alerts(_ sender: Any) {
        let url = "https://m.facebook.com/notifications"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
        
    }
    
    
    
    var emptyString = String()
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://m.facebook.com"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
        
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
    
    
}






