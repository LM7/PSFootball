//
//  SlideMenuHamView.swift
//  PSFootball
//
//  Created by Lorenzo on 07/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

protocol SlideMenuHamDelegate: NSObjectProtocol {
    
    func slideMenuAt(index: Int)
}

class SlideMenuHamView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var slideMenuHamDelegate: SlideMenuHamDelegate?
    
    let trailingMenu: CGFloat = 150.0
    
    var currentView: UIView?
    var currentNavigationBar: UINavigationBar?
    var tap: UITapGestureRecognizer?
    var arrayMenuOptions = [String]()
    
    var isOpen = false
    
    class func getSlideMenuHamView() -> SlideMenuHamView? {
        
        if let slideMenuHamView = Bundle.main.loadNibNamed("SlideMenuHamView", owner: nil, options: nil)?.first as? SlideMenuHamView {
            
            slideMenuHamView.tableView.delegate = slideMenuHamView
            slideMenuHamView.tableView.dataSource = slideMenuHamView
            slideMenuHamView.tableView.register(MenuCell.cellNib(), forCellReuseIdentifier: MenuCell.cellIdentifier())
            
            slideMenuHamView.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            slideMenuHamView.loadShadow()
            
            slideMenuHamView.arrayMenuOptions.append(SlideMenuHamOptionType.menuHome.getDescriptionForMenu())
            slideMenuHamView.arrayMenuOptions.append(SlideMenuHamOptionType.logout.getDescriptionForMenu())
            
            return slideMenuHamView
        }
        return nil
    }
    
    private func loadShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    func openMenu() {
        
        self.isOpen = true
        
        if let win = (UIApplication.shared.delegate?.window) as? UIWindow {
            
            win.addSubview(self)
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - self.trailingMenu, height: UIScreen.main.bounds.size.height)
                
                self.currentNavigationBar?.frame = CGRect(x: UIScreen.main.bounds.size.width - self.trailingMenu, y: 20.0, width: UIScreen.main.bounds.size.width, height: self.currentNavigationBar?.frame.height ?? 0.0)
                
                self.currentView?.frame = CGRect(x: UIScreen.main.bounds.size.width - self.trailingMenu, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                
                self.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
    func closeMenu() {
        
        self.isOpen = false
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.currentView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.currentNavigationBar?.frame = CGRect(x: 0, y: 20.0, width: UIScreen.main.bounds.size.width, height: self.currentNavigationBar?.frame.height ?? 0.0)

            self.layoutIfNeeded()
            
        }, completion: { (finished) -> Void in
            
            self.removeFromSuperview()
        })
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension SlideMenuHamView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menuCell = self.tableView.dequeueReusableCell(withIdentifier: MenuCell.cellIdentifier(), for: indexPath) as? MenuCell {
            
            menuCell.config(voceMenu: self.arrayMenuOptions[indexPath.row])
            return menuCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slideMenuHamDelegate?.slideMenuAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
