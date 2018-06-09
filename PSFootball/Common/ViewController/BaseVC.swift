//
//  BaseVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var slideMenuHamView: SlideMenuHamView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slideMenuHamView = SlideMenuHamView.getSlideMenuHamView()
        self.slideMenuHamView?.slideMenuHamDelegate = self
        
        self.setNavProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setNavProperties() {
        
        let imgBack = #imageLiteral(resourceName: "iconBall")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.addTarget(self, action: #selector(self.addSlideMenuButton), for: UIControlEvents.touchUpInside)
        button.setImage(imgBack, for: .normal)
        
        let leftButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func addSlideMenuButton() {
        
        if let slideMenuHamViewCurr = self.slideMenuHamView {
            
            if slideMenuHamViewCurr.isOpen {
                slideMenuHamViewCurr.closeMenu()
            } else {
                slideMenuHamViewCurr.openMenu()
            }
        }
    }
}

// MARK: SlideMenuHamDelegate

extension BaseVC: SlideMenuHamDelegate {
    
    func slideMenuAt(index: Int) {
        
        self.slideMenuHamView?.closeMenu()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch index {
            
            //controllo sullo stesso VC...
            
        case 0:
            
            if let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 1:
            break
            
        default:
            break
        }
    }
}
