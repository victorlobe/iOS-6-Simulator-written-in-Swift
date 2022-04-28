//
//  icloudLoginViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 28.04.22.
//  Copyright © 2022 Victor Lobe. All rights reserved.
//

import UIKit

class icloudLoginViewController: UIViewController {
    @IBOutlet weak var appleidField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginBtn(_ sender: Any) {
        UserDefaults.standard.set(appleidField.text, forKey: "iCloudUsername")
        UserDefaults.standard.set(passwordField.text, forKey: "iCloudPassword")
        if UserDefaults.standard.string(forKey: "iCloudUsername") == nil {} else {
            iCloudUsername = UserDefaults.standard.string(forKey: "iCloudUsername") ?? ""
        }
        if UserDefaults.standard.string(forKey: "iCloudPassword") == nil {} else {
            iCloudPassword = UserDefaults.standard.string(forKey: "iCloudPassword") ?? ""
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "iCloudUsername") == nil {} else {
            appleidField.text = UserDefaults.standard.string(forKey: "iCloudUsername")
        }
        if UserDefaults.standard.string(forKey: "iCloudPassword") == nil {} else {
            passwordField.text = UserDefaults.standard.string(forKey: "iCloudPassword")
        }
        
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
      self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
}
