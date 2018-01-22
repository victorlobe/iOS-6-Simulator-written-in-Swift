//
//  safariViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 11.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class safariViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var battery: UIImageView!
    @IBOutlet var urltextfield: UITextField!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var googleTextfield: UITextField!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var webTitle: UILabel!
    @IBOutlet var fail: UIImageView!
    
    
    var MyBattery: Float = 0.0
    var timer = Timer()
    @IBOutlet var shareOut: UIButton!
    
    
    @IBAction func share(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [self.webView.request?.url?.absoluteString], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        
        
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    
    
    
    
    
    override func viewDidLoad() {
        
        fail.isHidden = true
        
        
        
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 18.5)
        
        webView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        webTitle.text = "Ohne Titel"
        
        
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
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        self.progressBar.setProgress(0.1, animated: false)
        self.urltextfield.text = self.webView.request?.url?.absoluteString
        fail.isHidden = true
        
        webTitle.text = "Laden"
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.progressBar.setProgress(1.0, animated: true)
        
        
        
        self.urltextfield.text = self.webView.request?.url?.absoluteString
        
        let htmlTitle = webView.stringByEvaluatingJavaScript(from: "document.title");
        print(htmlTitle)
        webTitle.text = htmlTitle
        fail.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        self.progressBar.setProgress(1.0, animated: true)
        webTitle.text = "Seite kann nicht geöffnet werden"
        fail.isHidden = false
        
        
    }
    
    
    
    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .short
        
        
        timeLabel.text = timeFormatter.string(from: NSDate() as Date)
        
        
        
    }
    
    
    
    
    @IBAction func textfieldreturn(_ sender: Any) {
        
        let url = URL(string: "https://\(urltextfield.text!)")
        let urlrequest = URLRequest(url: url!)
        webView.loadRequest(urlrequest)
        webView.delegate=self
        
        
    }
    
    
    @IBAction func googlereturn(_ sender: Any) {
        
        urltextfield.text = ("https://www.google.de/search?=\(googleTextfield.text)")
       
        let keywords = googleTextfield.text
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "ö", with: "oe").replacingOccurrences(of: "Ö", with: "OE").replacingOccurrences(of: "ä", with: "ae").replacingOccurrences(of: "Ä", with: "AE").replacingOccurrences(of: "ü", with: "ue").replacingOccurrences(of: "Ü", with: "UE").replacingOccurrences(of: "ß  ", with: "ss")
        
        
        let url = URL(string: "https://www.google.de/#q=\(finalKeywords!)")
        let urlrequest = URLRequest(url: url!)
        webView.loadRequest(urlrequest)
        webView.delegate=self
        
        
        
        
    }
    
    
    
        
        
    
    
}







