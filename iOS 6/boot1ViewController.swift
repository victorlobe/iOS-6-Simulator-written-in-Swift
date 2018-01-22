//
//  boot1ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 08.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class boot1ViewController: UIViewController {
    
    var quickBoot = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
        
        
    }
    @IBAction func quickBoot(_ sender: Any) {
        quickBoot = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func timeToMoveOn() {
        if quickBoot == false {
        self.performSegue(withIdentifier: "boot1", sender: self)
        } else {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "boot1") {
            
            
            
            print("Segue Performed")
            print("boot1")
            
        }
        
    }

}
