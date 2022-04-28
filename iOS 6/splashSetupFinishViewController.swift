//
//  splashSetupFinishViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 21.06.21.
//  Copyright © 2021 Victor Lobe. All rights reserved.
//

import UIKit

class splashSetupFinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UserDefaults.standard.set(true, forKey: "directBoot")
        UserDefaults.standard.set(true, forKey: "setupDone")
        UserDefaults.standard.set(true, forKey: "batteryMonitoringAllowed")
    }
}
