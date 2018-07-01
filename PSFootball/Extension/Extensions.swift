//
//  Extensions.swift
//  PSFootball
//
//  Created by Lorenzo on 07/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: NSManagedObject

extension NSManagedObject {
    class func insertNewObjectInMOC(moc: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: self), into: moc)
    }
    
    class func fetchRequestForCurrentEntity() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: String(describing: self))
    }
}

// MARK: NSManagedObjectContext

extension NSManagedObjectContext {
    func deleteObjectsInArray(array: [NSManagedObject]) {
        for object in array {
            self.delete(object)
        }
    }
}

// MARK: UIColor

extension UIColor {
    
    class func bluePalette(level: PaletteLevel) -> UIColor {
        switch level {
        case .dark:
            return UIColor(red: 0.0/255, green: 51.0/255, blue: 204.0/255, alpha: 1.0)
        case .medium:
            return UIColor(red: 51.0/255, green: 102.0/255, blue: 255.0/255, alpha: 1.0)
        case .light:
            return UIColor(red: 102.0/255, green: 153.0/255, blue: 255.0/255, alpha: 1.0)
        }
    }
    
    class func greenPalette(level: PaletteLevel) -> UIColor {
        switch level {
        case .dark:
            return UIColor(red: 0.0/255, green: 153.0/255, blue: 51.0/255, alpha: 1.0)
        case .medium:
            return UIColor(red: 51.0/255, green: 204.0/255, blue: 51.0/255, alpha: 1.0)
        case .light:
            return UIColor(red: 102.0/255, green: 255.0/255, blue: 102.0/255, alpha: 1.0)
        }
    }
    
    class func redPalette(level: PaletteLevel) -> UIColor {
        switch level {
        case .dark:
            return UIColor(red: 204.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        case .medium:
            return UIColor(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        case .light:
            return UIColor(red: 255.0/255, green: 51.0/255, blue: 0.0/255, alpha: 1.0)
        }
    }
}

// MARK: UITableViewCell

extension UITableViewCell {
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cellNib() -> UINib {
        return UINib.init(nibName: cellIdentifier(), bundle: nil)
    }
}
