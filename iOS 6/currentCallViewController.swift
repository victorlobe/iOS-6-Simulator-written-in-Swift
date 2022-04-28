//
//  currentCallViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 12.05.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class currentCallViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var commandButtons: [UIButton]!
    @IBOutlet var commandButtonsView: UIView!
    @IBOutlet var hangUpBtnOut: UIButton!
    
    var currentDuration = 0
    var timer = Timer()
    
    @IBAction func commandButtonA(_ sender: Any) {
    }
    
    @IBAction func commandButtonB(_ sender: Any) {
    }
    
    @IBAction func commandButtonC(_ sender: Any) {
    }
    
    @IBAction func commandButtonD(_ sender: Any) {
    }
    
    @IBAction func commandButtonE(_ sender: Any) {
    }
    
    @IBAction func commandButtonF(_ sender: Any) {
    }
    
    @IBAction func hangUpBtn(_ sender: Any) {
        timer.invalidate()
        hangUpBtnOut.isUserInteractionEnabled = false
        durationLabel.text = "Anruf beenden..."
        commandButtonsView.alpha = 0.5
        hangUpBtnOut.setImage(UIImage(named: "phoneBeendenBtnWhileHangUp"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commandButtons[0].setBackgroundImage(UIImage(named: "sixsqbuttonsel_1"), for: .highlighted)
        commandButtons[0].setBackgroundImage(UIImage(named: "sixsqbuttonsel_1"), for: .selected)

        commandButtons[1].setBackgroundImage(UIImage(named: "sixsqbuttonsel_2"), for: .highlighted)
        commandButtons[1].setBackgroundImage(UIImage(named: "sixsqbuttonsel_2"), for: .selected)
        
        commandButtons[2].setBackgroundImage(UIImage(named: "sixsqbuttonsel_3"), for: .highlighted)
        commandButtons[2].setBackgroundImage(UIImage(named: "sixsqbuttonsel_3"), for: .selected)
        
        commandButtons[3].setBackgroundImage(UIImage(named: "sixsqbuttonsel_4"), for: .highlighted)
        commandButtons[3].setBackgroundImage(UIImage(named: "sixsqbuttonsel_4"), for: .selected)
        
        commandButtons[4].setBackgroundImage(UIImage(named: "sixsqbuttonsel_5"), for: .highlighted)
        commandButtons[4].setBackgroundImage(UIImage(named: "sixsqbuttonsel_5"), for: .selected)
        
        commandButtons[5].setBackgroundImage(UIImage(named: "sixsqbuttonsel_6"), for: .highlighted)
        commandButtons[5].setBackgroundImage(UIImage(named: "sixsqbuttonsel_6"), for: .selected)
        
        nameLabel.text = UserDefaults.standard.string(forKey: "callSessionNumber")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDuration), userInfo: nil, repeats: true)
    }
    
    @objc func updateDuration() {
        currentDuration += 1
        let hours = currentDuration / 3600
        let mins = currentDuration / 60 % 60
        let secs = currentDuration % 60
        let restTime = ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)
        durationLabel.text = restTime
        
        
        
    }
    
}
