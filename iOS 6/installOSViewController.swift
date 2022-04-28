//
//  installOSViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 31.08.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class installOSViewController: UIViewController {
    @IBOutlet var installBtnOut: UIButton!
    @IBOutlet var installBarOut: UIProgressView!
    @IBOutlet var remainingTimeLabel: UILabel!
    
    @IBAction func installBtn(_ sender: Any) {
        installBarOut.setProgress(0.1, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installBarOut.setProgress(0, animated: false)
        remainingTimeLabel.text = ""
        installBarOut.trackImage = UIImage(named: "sliderTrackUnfilledTexture")
        installBarOut.progressImage = UIImage(named: "sliderTrackFilledTexture")
    }
}
