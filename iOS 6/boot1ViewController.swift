//
//  boot1ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 08.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class boot1ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func quickBoot(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "directBoot") == true {
            self.performSegue(withIdentifier: "startToLockscreen", sender: self)
        } else {
            if UserDefaults.standard.bool(forKey: "debugging") == true {
                self.performSegue(withIdentifier: "boot1", sender: self)
            } else {
                self.performSegue(withIdentifier: "startToBooter", sender: self)
            }
        }
    }
    
    @IBAction func closeAppBtn(_ sender: Any) {
        Darwin.abort()
    }
    

}
