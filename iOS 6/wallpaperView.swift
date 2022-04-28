//
//  wallpaperView.swift
//  iOS 6
//
//  Created by Victor Lobe on 10.05.20.
//  Copyright © 2020 Victor Lobe. All rights reserved.
//

import UIKit

class wallpaperView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image = UIImage(named: UserDefaults.standard.string(forKey: "wallpaperResourceString") ?? "100_iPad")
        contentMode = .scaleAspectFill
    }
}
