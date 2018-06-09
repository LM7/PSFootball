//
//  FirebaseManager.swift
//  PSFootball
//
//  Created by Lorenzo on 09/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

typealias FBMSuccessBlock = ((_  json : Any) -> Void)
typealias FBMFailureBlock = ((_ error : Error) -> Void)
typealias FBMSuccessVoidBlock = (() -> Void)
typealias FBMFailurVoidBlock = (() -> Void)

class FirebaseManager {
    
    class func createUser(email: String, password: String, success: FBMSuccessBlock? = nil, failure: FBMFailureBlock? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            
            if let userCurr = user {
                success?(userCurr)
            } else if let errorCurr = error {
                failure?(errorCurr)
            }
        }
    }
    
    class func login(email: String, password: String, success: FBMSuccessBlock? = nil, failure: FBMFailureBlock? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { (user: User?, error: Error?) in
            
            if let userCurr = user {
                success?(userCurr)
            } else if let errorCurr = error {
                failure?(errorCurr)
            }
        }
    }
}
