//
//  mvgViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 04.04.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class mvgViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    @IBOutlet var verbindungenBtnOut: UIButton!
    @IBOutlet var abfahrtenBtnOut: UIButton!
    @IBOutlet var meldungenBtnOut: UIButton!
    @IBOutlet var ticketsBtnOut: UIButton!
    @IBOutlet var bottomBarOut: UIImageView!
    
    @IBAction func verbindung(_ sender: Any) {
        verbindungenBtnOut.isUserInteractionEnabled = false
        abfahrtenBtnOut.isUserInteractionEnabled = true
        meldungenBtnOut.isUserInteractionEnabled = true
        ticketsBtnOut.isUserInteractionEnabled = true
        bottomBarOut.image = UIImage(named: "mvgBarVerbindung")
        let requestURL = URL(string: "https://www.mvg.de/dienste/verbindungen.html")
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    @IBAction func abfahrten(_ sender: Any) {
        verbindungenBtnOut.isUserInteractionEnabled = true
        abfahrtenBtnOut.isUserInteractionEnabled = false
        meldungenBtnOut.isUserInteractionEnabled = true
        ticketsBtnOut.isUserInteractionEnabled = true
        bottomBarOut.image = UIImage(named: "mvgBarAbfahrten")
        let requestURL = URL(string: "https://www.mvg.de/dienste/abfahrtszeiten.html")
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    @IBAction func meldungen(_ sender: Any) {
        verbindungenBtnOut.isUserInteractionEnabled = true
        abfahrtenBtnOut.isUserInteractionEnabled = true
        meldungenBtnOut.isUserInteractionEnabled = false
        ticketsBtnOut.isUserInteractionEnabled = true
        bottomBarOut.image = UIImage(named: "mvgBarMeldungen")
        let requestURL = URL(string: "https://www.mvg.de/dienste/betriebsaenderungen.html")
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    @IBAction func tickets(_ sender: Any) {
        verbindungenBtnOut.isUserInteractionEnabled = true
        abfahrtenBtnOut.isUserInteractionEnabled = true
        meldungenBtnOut.isUserInteractionEnabled = true
        ticketsBtnOut.isUserInteractionEnabled = false
        bottomBarOut.image = UIImage(named: "mvgBarTickets")
        let requestURL = URL(string: "https://www.mvg.de/tickets-tarife.html")
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = URL(string: "https://www.mvg.de/dienste/verbindungen.html")
        let request = URLRequest(url: requestURL!)
        webView.delegate = self
        webView.loadRequest(request)
        
    }
    
}
