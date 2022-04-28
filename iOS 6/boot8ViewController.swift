//
//  boot8ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 08.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class boot8ViewController: UIViewController {
    
    var emptyString = String()
    
    
    
    @IBOutlet var timeanddate: UILabel!
    
    var timer = Timer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc func updateTimer() {
        
        
        let timeFormatter = DateFormatter()
        
        
        timeFormatter.timeStyle = .full
        
        
        timeanddate.text = timeFormatter.string(from: NSDate() as Date)
        
        
}
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "boot8", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "boot8") {
            
            
            
            print("Segue Performed")
            print("boot8")

        }
        
    }
    
    
    
}
