//
//  HomeVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = [(title: String, nameImage: String)]()
    
    override var titleNav: String? {
        get { return "MENU" }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(HomeCell.cellNib(), forCellWithReuseIdentifier: HomeCell.cellIdentifier())
        self.loadDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DManager.isMenuHome = true
        
        PSFootballHelper.trackAnswers(withName: "HomeVC")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DManager.isMenuHome = false
    }
    
    // MARK: Private Functions
    private func loadDataSource() {
        self.dataSource.append((title: MenuOptionType.fifa98.rawValue, nameImage: MenuOptionType.fifa98.getNameImage()))
        self.dataSource.append((title: MenuOptionType.fifa99.rawValue, nameImage: MenuOptionType.fifa99.getNameImage()))
        self.dataSource.append((title: MenuOptionType.fifa2000.rawValue, nameImage: MenuOptionType.fifa2000.getNameImage()))
        self.dataSource.append((title: MenuOptionType.fifa2001.rawValue, nameImage: MenuOptionType.fifa2001.getNameImage()))
    }
    
    private func goToVCfromType(menuOption: MenuOptionType) {
        switch menuOption {
            
        case .fifa98:
            let storyboard = UIStoryboard(name: "AlboOro", bundle: nil)
            if let alboOroMenuVC = storyboard.instantiateViewController(withIdentifier: "AlboOroMenuVCID") as? AlboOroMenuVC {
                self.navigationController?.pushViewController(alboOroMenuVC, animated: true)
            }
            
        case .fifa99:
            let storyboard = UIStoryboard(name: "Competizioni", bundle: nil)
            if let competizioniMenuVC = storyboard.instantiateViewController(withIdentifier: "CompetizioniMenuVCID") as? CompetizioniMenuVC {
                self.navigationController?.pushViewController(competizioniMenuVC, animated: true)
            }
            
        case .fifa2000:
            let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
            if let rankingMenuVC = storyboard.instantiateViewController(withIdentifier: "RankingMenuVCID") as? RankingMenuVC {
                self.navigationController?.pushViewController(rankingMenuVC, animated: true)
            }
            
        case .fifa2001:
            let storyboard = UIStoryboard(name: "StoriaClub", bundle: nil)
            if let storiaClubMenuVC = storyboard.instantiateViewController(withIdentifier: "StoriaClubMenuVCID") as? StoriaClubMenuVC {
                self.navigationController?.pushViewController(storiaClubMenuVC, animated: true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let homeCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellIdentifier(), for: indexPath) as? HomeCell {
            
            homeCell.config(title: self.dataSource[indexPath.row].title, nameImage: self.dataSource[indexPath.row].nameImage)
            return homeCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthCell = (PSFootballHelper.getWidthDevice() / 2.0) - 10
        let heightCell: CGFloat = 200.0
        
        return CGSize(width: widthCell, height: heightCell)
        
//        let constantWidth = (1 / 5) * view.frame.width
//        let availableWidth = view.frame.width - constantWidth
//        let widthPerItem = availableWidth / 2
//
//        return CGSize(width: widthPerItem, height: HomeCell.getHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        
//        let constantWidth = (4 / 5) * view.frame.width
//        let availableWidth = view.frame.width - constantWidth
//        let widthPerItem = availableWidth / 3
//
//        return UIEdgeInsets(top: 50.0, left: widthPerItem, bottom: 20.0, right: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let menuOption = MenuOptionType(rawValue: self.dataSource[indexPath.row].title) {
            self.goToVCfromType(menuOption: menuOption)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
}
