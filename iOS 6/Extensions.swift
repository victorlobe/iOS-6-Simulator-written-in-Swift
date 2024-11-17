//
//  Extensions.swift
//  iOS 6
//
//  Created by Victor on 17.11.24.
//  Copyright © 2024 Victor Lobe. All rights reserved.
//

import Foundation
public func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
