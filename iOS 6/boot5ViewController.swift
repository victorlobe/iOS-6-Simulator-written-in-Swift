//
//  boot5ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 08.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class boot5ViewController: UIViewController {
    
    @IBOutlet var args: UITextField!
    
    @IBAction func argsReturn(_ sender: Any) {
    
    
        argsLabel.text = args.text
        
        if argsLabel.text == "quick" {
                    self.performSegue(withIdentifier: "toLockQuick", sender: self)
        }
        
        if argsLabel.text == "unknown battery" {
            
            self.performSegue(withIdentifier: "triggerBatteryError", sender: self)
            
            
        }
        
        if argsLabel.text == "no battery" {
            
            UIDevice.current.isBatteryMonitoringEnabled = false
            
            
            
        }
        
        
        
        
    }
        
    
    @IBOutlet var argsLabel: UILabel!
    
    
    
    
    var emptyString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "boot5", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "boot5") {
            
            
            
            print("Segue Performed")
            print("boot5")

        }
        
    }
    
}
