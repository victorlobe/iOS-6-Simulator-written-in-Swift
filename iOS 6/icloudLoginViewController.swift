//
//  icloudLoginViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 28.04.22.
//  Copyright © 2022 Victor Lobe. All rights reserved.
//

import UIKit
import Postal

class icloudLoginViewController: UIViewController {
    @IBOutlet weak var appleidField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet var loadingViewOut: UIView!
    
    @IBAction func loginBtn(_ sender: Any) {
        loadingViewOut.isHidden = false
        checkLogin()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingViewOut.roundCorners(corners: .allCorners, radius: 5)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingViewOut.isHidden = true
        if UserDefaults.standard.string(forKey: "iCloudUsername") == nil {} else {
            appleidField.text = UserDefaults.standard.string(forKey: "iCloudUsername")
        }
        if UserDefaults.standard.string(forKey: "iCloudPassword") == nil {} else {
            passwordField.text = UserDefaults.standard.string(forKey: "iCloudPassword")
        }
        
    }
    
    func checkLogin() {
        let postal = Postal(configuration: .icloud(login: appleidField.text ?? "", password: passwordField.text ?? ""))
        postal.connect { result in
            switch result {
            case .success:
                print("[EMAIL_BACKGROUND_SERVICE]: Login succeded!")
                self.saveLogin()
            case .failure(let error):
                print("[EMAIL_BACKGROUND_SERVICE]: Login failed: \(error)")
                self.loadingViewOut.isHidden = true
                self.sendAlert(title: "Error", message: "Could not login to iCloud.", confirmTitle: "OK")
            }
        }
    }
    
    func saveLogin() {
        UserDefaults.standard.set(appleidField.text, forKey: "iCloudUsername")
        UserDefaults.standard.set(passwordField.text, forKey: "iCloudPassword")
        if UserDefaults.standard.string(forKey: "iCloudUsername") == nil {} else {
            iCloudUsernameL = UserDefaults.standard.string(forKey: "iCloudUsername") ?? ""
        }
        if UserDefaults.standard.string(forKey: "iCloudPassword") == nil {} else {
            iCloudPasswordL = UserDefaults.standard.string(forKey: "iCloudPassword") ?? ""
        }
        self.dismiss(animated: true)
    }
    
    func sendAlert(title: String, message: String, confirmTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
