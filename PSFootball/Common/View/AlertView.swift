//
//  AlertView.swift
//  PSFootball
//
//  Created by Lorenzo on 25/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    @IBOutlet weak var alertMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    class func showAlert(alertType: AlertType, message: String) {
        
        if
            let alertView = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?.first as? AlertView,
            let win = (UIApplication.shared.delegate?.window) as? UIWindow {
            
            alertView.titleLabel.text = alertType.rawValue
            alertView.subtitleLabel.text = message
            alertView.loadGraphic(alertType: alertType)
            alertView.frame = win.bounds
            
            win.addSubview(alertView)
        }
    }
    
    private func loadGraphic(alertType: AlertType) {
        self.backgroundColor = UIColor.clear
        self.alertMainView.layer.cornerRadius = 10.0
        self.okButton.layer.cornerRadius = 6.0
        self.titleLabel.textColor = (alertType == AlertType.error) ? UIColor.redPalette(level: .medium) : UIColor.bluePalette(level: .medium)
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
}
