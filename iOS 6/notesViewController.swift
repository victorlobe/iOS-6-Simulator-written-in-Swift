//
//  notesViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 12.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class notesViewController: UIViewController {
    @IBOutlet var textField: UITextView!
    @IBOutlet var backBtnOut: UIButton!
    @IBOutlet var addBtnOut: UIButton!
    
    @IBAction func clear(_ sender: Any) {
        
        textField.text = ""
        
        
    }
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
    }
    
    override func viewDidLoad() {
        backBtnOut.setBackgroundImage(UIImage(named: "NOTESheader back pressed"), for: .highlighted)
        backBtnOut.setBackgroundImage(UIImage(named: "NOTESheader back pressed"), for: .selected)
        addBtnOut.setBackgroundImage(UIImage(named: "NOTESheader button pressed"), for: .highlighted)
        addBtnOut.setBackgroundImage(UIImage(named: "NOTESheader button pressed"), for: .selected)
        

    }
    
    @IBAction func dismiss(_ sender: Any) {
        UserDefaults.standard.set(textField.text, forKey: "notes")
        
        textField.text = (textField.text)!
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
        
        
    {
        if let x = UserDefaults.standard.object(forKey: "notes") as? String
            
        {
            textField.text = x
            
        }
        
        
    }
    
    
    
}








