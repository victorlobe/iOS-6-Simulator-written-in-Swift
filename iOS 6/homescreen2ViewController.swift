//
//  homescreen2ViewController.swift
//  iOS 6
//
//  Created by Victor Lobe on 11.06.17.
//  Copyright © 2017 Victor Lobe. All rights reserved.
//

import UIKit

class homescreen2ViewController: UIViewController {
    
    let launchScreenImageView = UIImageView()
    var launchscreenVisible = false
    
    @IBOutlet var wallpaperImageView: UIImageView!
    
    @IBAction func mvgBtn(_ sender: Any) {
        launchScreenImageView.image = UIImage(named: "launchscreenMVG")
        UIView.animate(withDuration: 0.3) {
            self.launchScreenImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        launchscreenVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "homeToMVG", sender: self)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchScreenImageView.frame = CGRect(x: wallpaperImageView.frame.origin.x, y: wallpaperImageView.frame.origin.y, width: wallpaperImageView.frame.width, height: wallpaperImageView.frame.height)
        launchScreenImageView.contentMode = .scaleAspectFit
        view.addSubview(launchScreenImageView)
        launchScreenImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        launchscreenVisible = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if launchscreenVisible == true {
            UIView.animate(withDuration: 0.3) {
                self.launchScreenImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
            self.launchscreenVisible = false
        }
    }
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .all
    }
    
}






