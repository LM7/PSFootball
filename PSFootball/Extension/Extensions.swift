//
//  Extensions.swift
//  PSFootball
//
//  Created by Lorenzo on 07/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import UIKit

// MARK: UITableViewCell

extension UITableViewCell {
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cellNib() -> UINib {
        return UINib.init(nibName: cellIdentifier(), bundle: nil)
    }
}
