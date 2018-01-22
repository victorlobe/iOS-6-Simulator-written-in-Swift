//
//  testViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 18.08.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit
import UIView_Shimmer
import Shimmer

class testViewController: UIViewController {

    @IBOutlet var unlockColor: UIView!
    @IBOutlet var colorView: UIView!
    @IBOutlet var indicator: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var shimmerTest: FBShimmeringView!
    @IBOutlet var shimmerView: FBShimmeringView!
    
    @IBAction func one(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "1"
        
    }
    @IBAction func two(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "2"
        
        
    }
    
    @IBAction func three(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "3"
        
    }
    
    
    @IBAction func four(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "4"
        
    }
    @IBAction func five(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "5"
        
    }
    
    @IBAction func six(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "6"
        
    }
    
    @IBAction func seven(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "7"
        
    }
    @IBAction func eight(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "8"
        
    }
    
    @IBAction func nine(_ sender: Any) {
        
        numberLabel.text = (numberLabel.text ?? "") + "9"
    }
    
    @IBAction func zero(_ sender: Any) {
        numberLabel.text = (numberLabel.text ?? "") + "0"
        
    }
    
    @IBOutlet var dotA: UILabel!
    @IBOutlet var dotB: UILabel!
    @IBOutlet var dotC: UILabel!
    @IBOutlet var dotD: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        numberLabel.startShimmering()
        
        let label = UILabel(frame: self.shimmerView.bounds)
        label.textAlignment = .center
        label.text = "A Song For You"
        self.shimmerView.contentView = label
        self.shimmerView.isShimmering = true
        
        
    Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(statusCheck), userInfo: nil, repeats: true)
            
        
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(indicatorDelay), userInfo: nil, repeats: true)
        
        
        
        
    }
    
    
    func statusCheck() {
        
        
        
        var numChars = numberLabel.text?.characters.count ?? 0
        numChars = numberLabel.text?.characters.count ?? 0
        
        
        
        if numChars == 1 {
            dotA.isHidden = false
            
        }
        if numChars == 2 {
            dotB.isHidden = false

            
        }
        if numChars == 3 {
            dotC.isHidden = false

            
        }
        if numChars == 4 {
            dotD.isHidden = false

            if numberLabel.text == "1234" {
                status.text = "unlocked!"
                unlockColor.backgroundColor = UIColor.green
                
            } else {
               unlockColor.backgroundColor = UIColor.darkGray
                status.text = "WRONG CODE!"
                
                
            }
            
        }
        
        
    
    }
    
    func indicatorDelay() {
        
        indicator.text = "ready"
        
        colorView.backgroundColor = UIColor.green
        
    }
    
    

}
