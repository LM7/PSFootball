//
//  CoreDataHelper.swift
//  PSFootball
//
//  Created by Lorenzo on 01/07/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static var moc: NSManagedObjectContext?
    
    // MARK: User
    
    class func fetchInsertPSUser(email: String) -> PSUser? {
        
        var psUser: PSUser!
        moc = cdmPSF.mainMOC
        
        do {
            let request = PSUser.fetchRequestForCurrentEntity()
            request.predicate = NSPredicate(format: "email == %@", email)
            
            if let result = try moc?.fetch(request).first as? PSUser {
                psUser = result
                
            } else {
                psUser = self.createPSUser()
            }
            return psUser
        } catch {
            return nil
        }
    }
    
    class func createPSUser() -> PSUser? {
        moc = cdmPSF.mainMOC
        if
            let moc = moc,
            let psUser = PSUser.insertNewObjectInMOC(moc: moc) as? PSUser {
            
            return psUser
        }
        return nil
    }
}
