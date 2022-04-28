//
//  noverbosebootViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 29.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class noverbosebootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: 35.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
    }

    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "tolocknoverbose", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "tolocknoverbose") {
            
            
            
            print("Segue Performed")
            print("boot5")
            
        }
        
    }

}
