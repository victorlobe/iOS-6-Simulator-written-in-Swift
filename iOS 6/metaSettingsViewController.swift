//
//  metaSettingsViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 04.04.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class metaSettingsViewController: UIViewController {
    @IBOutlet var batteryMonitoringSwitchOut: UISwitch!
    @IBOutlet var codeFieldOut: UITextField!
    @IBOutlet var debuggingSwitchOut: UISwitch!
    @IBOutlet var quickBootSwitchOut: UISwitch!
    @IBOutlet weak var iCloudBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        batteryMonitoringSwitchOut.setOn(UserDefaults.standard.bool(forKey: "batteryMonitoringAllowed"), animated: false)
        debuggingSwitchOut.setOn(UserDefaults.standard.bool(forKey: "debugging"), animated: false)
        quickBootSwitchOut.setOn(UserDefaults.standard.bool(forKey: "directBoot"), animated: false)

        codeFieldOut.text = UserDefaults.standard.string(forKey: "passcode")
        
        if UserDefaults.standard.string(forKey: "iCloudUsername") == "" {
            iCloudBtnOut.setTitle("Login to iCloud", for: .normal)
        } else {
            iCloudBtnOut.setTitle("Logout from iCloud", for: .normal)
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearMailCache(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "lastMail")
    }
    
    @IBAction func debuggingSwitch(_ sender: Any) {
        UserDefaults.standard.set(debuggingSwitchOut.isOn, forKey: "debugging")
    }
    
    @IBAction func quickBootSwitch(_ sender: Any) {
        UserDefaults.standard.set(quickBootSwitchOut.isOn, forKey: "directBoot")

    }
    @IBAction func iCloudBtn(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "iCloudUsername") == "" {
            self.performSegue(withIdentifier: "metaSettingsToIcloud", sender: self)
        } else {
            UserDefaults.standard.set("", forKey: "iCloudUsername")
            UserDefaults.standard.set("", forKey: "iCloudPassword")
            iCloudBtnOut.setTitle("Login to iCloud", for: .normal)

        }
    }
    
    @IBAction func codeEnter(_ sender: Any) {
        UserDefaults.standard.set(codeFieldOut.text, forKey: "passcode")
        self.view.endEditing(true)
    }
    
    @IBAction func batteryMonitoringSwitch(_ sender: Any) {
        UserDefaults.standard.set(batteryMonitoringSwitchOut.isOn, forKey: "batteryMonitoringAllowed")
    }
}
