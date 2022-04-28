//
//  SettingsBundleHelper.swift
//  Mein Schiff 6 Bordfinder
//
//  Created by Victor Lobe on 16.02.18.
//  Copyright © 2018 Victor Lobe. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let clearMailCache = "clearMailCache"
    }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.clearMailCache) {
            UserDefaults.standard.set("", forKey: "lastMail")
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.clearMailCache)
        }
    }
}
