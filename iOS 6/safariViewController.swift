//
//  safariViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 11.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class safariViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var urltextfield: UITextField!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var googleTextfield: UITextField!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var webTitle: UILabel!
    @IBOutlet var fail: UIImageView!
    
    @IBOutlet var shareOut: UIButton!
    
    
    @IBAction func share(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [self.webView.request?.url?.absoluteString], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        
        
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    
    
    
    
    
    override func viewDidLoad() {
        
        fail.isHidden = true
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 8.2)
        
        webView.delegate = self
                
        webTitle.text = "Ohne Titel"
        
        if UserDefaults.standard.url(forKey: "safariURL") == nil {} else {
            let requestURL = UserDefaults.standard.url(forKey: "safariURL")
            let request = URLRequest(url: requestURL!)
            webView.loadRequest(request)
        }

        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UserDefaults.standard.set(self.webView.request?.url, forKey: "safariURL")
        self.progressBar.setProgress(0.1, animated: false)
        self.urltextfield.text = self.webView.request?.url?.absoluteString
        fail.isHidden = true
        self.progressBar.isHidden = false
        webTitle.text = "Laden"
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.progressBar.setProgress(1.0, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.progressBar.isHidden = true
        }
        
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
    
    
    
        
        
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
    }
    
}







