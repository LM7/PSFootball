//
//  PSUser+CoreDataProperties.swift
//  PSFootball
//
//  Created by Lorenzo on 01/07/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//
//

import Foundation
import CoreData


extension PSUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PSUser> {
        return NSFetchRequest<PSUser>(entityName: "PSUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
