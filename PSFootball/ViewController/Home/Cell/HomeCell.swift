//
//  HomeCell.swift
//  PSFootball
//
//  Created by Lorenzo on 03/07/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageTitleView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12.0
    }
    
    class func getHeight() -> CGFloat {
        return 150.0
    }
    
    func config(title: String, nameImage: String) {
        self.titleLabel.text = title
        self.imageTitleView.image = UIImage(named: nameImage)
    }
}
