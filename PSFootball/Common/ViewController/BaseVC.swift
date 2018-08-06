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
    var titleNav: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slideMenuHamView = SlideMenuHamView.getSlideMenuHamView()
        
        self.slideMenuHamView?.slideMenuHamDelegate = self
        self.slideMenuHamView?.currentView = self.view
        self.slideMenuHamView?.currentNavigationBar = self.navigationController?.navigationBar
        
        self.setNavProperties()
        self.loadGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        if let isOpen = self.slideMenuHamView?.isOpen, isOpen {
            self.slideMenuHamView?.closeMenu()
        }
    }
    
    private func setNavProperties() {
        
        let imgBack = #imageLiteral(resourceName: "iconBall")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redPalette(level: .dark)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.addTarget(self, action: #selector(self.addSlideMenuButton), for: UIControlEvents.touchUpInside)
        button.setImage(imgBack, for: .normal)
        
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftButton
        
        if let title = self.titleNav, !title.isEmpty {
            self.navigationItem.title = title
            let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        }
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
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch index {
            
        case 0:
            if !DManager.isMenuHome {
                self.navigationController?.popViewController(animated: false)
            }
            
        case 1:
            do {
                try FirebaseManager.logout()
                
            } catch let error {
                print(error.localizedDescription)
                AlertView.showAlert(alertType: AlertType.error, message: "Logout Error")
            }

            VideoManager.resume()
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.popToRootViewController(animated: true)
            
        default:
            break
        }
    }
}
