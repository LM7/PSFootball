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
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult: AuthDataResult?, error: Error?) in
            
            if let user = authDataResult?.user {
                success?(user)
            } else if let errorCurr = error {
                failure?(errorCurr)
            }
        }
    }
    
    class func login(email: String, password: String, success: FBMSuccessBlock? = nil, failure: FBMFailureBlock? = nil) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult: AuthDataResult?, error: Error?) in
            
            if let user = authDataResult?.user {
                success?(user)
            } else if let errorCurr = error {
                failure?(errorCurr)
            }
        }
    }
    
    class func logout() throws {
        try? Auth.auth().signOut()
    }
    
    class func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    class func getReferenceDB() -> DatabaseReference {
        return Database.database().reference()
    }
    
    class func getReferenceDBUsers() -> DatabaseReference {
        let ref = self.getReferenceDB()
        return ( ref.child("NODO_USERS".localized) )
    }
    
    class func getReferenceDBUserUID() -> DatabaseReference? {
        guard let currentUser: User = FirebaseManager.getCurrentUser() else { return nil }
        
        let refUsers = self.getReferenceDBUsers()
        return ( refUsers.child(currentUser.uid) )
    }
}
