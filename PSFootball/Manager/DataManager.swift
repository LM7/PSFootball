//
//  DataManager.swift
//  PSFootball
//
//  Created by Lorenzo on 09/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import Firebase

let DManager = DataManager.getInstance

class DataManager {
    
    static let getInstance = DataManager()
    
    var user: User?
}
