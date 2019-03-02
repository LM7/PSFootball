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

enum SlideMenuHamOptionType: Int {
    
    case menuHome = 0
    case logout = 1
    
    func getDescriptionForMenu() -> String {
        switch self {
            
        case .menuHome:
            return "Menu"
            
        case .logout:
            return "Logout"
        }
    }
}

enum MenuOptionType: String {
    
    case fifa98 = "FIFA 98"
    case fifa99 = "FIFA 99"
    case fifa2000 = "FIFA 2000"
    case fifa2001 = "FIFA 2001"
    
    func getNameImage() -> String {
        switch self {
            
        case .fifa98, .fifa99, .fifa2000, .fifa2001:
            return "easports"
        }
    }
}
