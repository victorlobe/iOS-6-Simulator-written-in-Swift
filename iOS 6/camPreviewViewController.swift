//
//  camPreviewViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 29.07.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class camPreviewViewController: UIViewController {
    
    
    @IBOutlet var previewImage: UIImageView!
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentPic = UserDefaults.standard.object(forKey: "camCurrentPhoto") {
            previewImage.image = currentPic as! UIImage
        }
    }
}
