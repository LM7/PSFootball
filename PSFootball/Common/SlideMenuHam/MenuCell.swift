//
//  MenuCell.swift
//  PSFootball
//
//  Created by Lorenzo on 07/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var voceMenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(voceMenu: String) {
        self.voceMenuLabel.text = voceMenu
    }
}
