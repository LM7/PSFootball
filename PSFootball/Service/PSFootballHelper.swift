//
//  PSFootballHelper.swift
//  PSFootball
//
//  Created by Lorenzo on 06/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Crashlytics

class PSFootballHelper {
    
    class func getSafeAreaTopLeft() -> CGFloat?  {
        if #available(iOS 11.0, *) {
            if let safeAreaInsetsTop = UIApplication.shared.windows.first?.safeAreaInsets.top, safeAreaInsetsTop != 0  {
                return safeAreaInsetsTop
            } else if let safeAreaInsetsLeft = UIApplication.shared.windows.first?.safeAreaInsets.left, safeAreaInsetsLeft != 0 {
                return safeAreaInsetsLeft
            }
        }
        return nil
    }
    
    // MARK: Answers
    class func trackAnswers(withName: String) {
//        Answers.logContentView(withName: "Tweet", contentType: "Video", contentId: "1234", customAttributes: ["Favorites Count":20, "Screen Orientation":"Landscape"])
        Answers.logContentView(withName: withName, contentType: nil, contentId: nil, customAttributes: nil)
    }
    
    // MARK: Keychain
    class func saveOnKeychain(key: String, value: String) -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key)
    }
    
    class func getFromKeychain(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
}
