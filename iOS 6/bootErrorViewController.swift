//
//  bootErrorViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 19.08.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class bootErrorViewController: UIViewController {

    @IBOutlet var errorMessage: UITextView!
    @IBOutlet var argsLabel: UILabel!
    @IBOutlet var args: UITextField!
    
    
    @IBAction func argsReturn(_ sender: Any) {
        argsLabel.text = args.text
        
        if argsLabel.text == "ignore" {
            
            self.errorMessage.font = UIFont(name: "Courier", size: 17)
            
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                
                self.performSegue(withIdentifier: "ignoreError", sender: self)
                
                
            }
            
        }
        
        if argsLabel.text == "exit" {
            
            abort()
            
            
            
        }
        
        if argsLabel.text == "reactivate" {
            
            UIDevice.current.isBatteryMonitoringEnabled = true
            
            
        }
        
        if argsLabel.text == "disable monitoring" {
            UIDevice.current.isBatteryMonitoringEnabled = false
            

        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    


}
