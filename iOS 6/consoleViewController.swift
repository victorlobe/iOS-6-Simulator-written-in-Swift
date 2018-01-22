//
//  consoleViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 06.08.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class consoleViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: Selector(("batteryStateDidChange:")), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("batteryLevelDidChange:")), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        
        // Stuff...
    
    }
        
    func batteryStateDidChange(notification: NotificationCenter){

        label.text = NSNotification.Name.UIDeviceBatteryLevelDidChange.rawValue
        
        
    }
    
    func batteryLevelDidChange(notification: NotificationCenter){
        // The battery's level did change (98%, 99%, ...)
    }
        
    
    
    
    
    
    
    
}
