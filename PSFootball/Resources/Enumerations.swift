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
    
    case alboOro = "ALBO D'ORO"
    case ranking = "RANKING"
    case competizioni = "COMPETIZIONI"
    case storia = "STORIA DEI CLUB"
    
    func getNameImage() -> String {
        switch self {
            
        case .alboOro:
            return "alboOro"
            
        case .ranking:
            return "ranking"
            
        case .competizioni:
            return "competizione"
            
        case .storia:
            return "storiaClub"
        }
    }
}
