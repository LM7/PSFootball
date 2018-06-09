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
    
    var arrayMenuOptions = [String]()
    
    var isOpen = false
    
    class func getSlideMenuHamView() -> SlideMenuHamView? {
        
        if let slideMenuHamView = Bundle.main.loadNibNamed("SlideMenuHamView", owner: nil, options: nil)?.first as? SlideMenuHamView {
            
            slideMenuHamView.tableView.delegate = slideMenuHamView
            slideMenuHamView.tableView.dataSource = slideMenuHamView
            
            slideMenuHamView.tableView.register(MenuCell.cellNib(), forCellReuseIdentifier: MenuCell.cellIdentifier())
            
            slideMenuHamView.arrayMenuOptions.append("Home")
            
            slideMenuHamView.loadGesture()
            
            return slideMenuHamView
        }
        return nil
    }
    
    private func loadGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.closeMenu()
    }
    
    func openMenu() {
        
        self.isOpen = true
        
        if let win = (UIApplication.shared.delegate?.window) as? UIWindow {
            
            win.addSubview(self)
            
            self.layoutIfNeeded()
            
            self.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                
            }, completion:nil)
        }
    }
    
    func closeMenu() {
        
        self.isOpen = false
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
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
