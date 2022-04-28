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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://m.facebook.com"
        
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
        
   
        
    }
    
    
    
}






