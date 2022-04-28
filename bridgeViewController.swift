//
//  bridgeViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 21.06.21.
//  Copyright © 2021 Victor Lobe. All rights reserved.
//

import UIKit

class bridgeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "setupDone") == true {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMain", sender: self)
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toSplash", sender: self)
            }
        }
    }
    
}
