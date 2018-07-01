//
//  Enumaration.swift
//  PSFootball
//
//  Created by Lorenzo on 06/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation

enum EnvironmentType {
    case test
    case coll
    case prod
}

enum AlertType: String {
    
    case success = "COMPLIMENTI"
    case error = "ATTENZIONE"
}

enum PaletteLevel: Float {
    case dark = 1.0
    case medium = 0.5
    case light = 0.25
}
