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
        
        self.loadLongPressGesture()
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
        self.dataSource.append((title: MenuOptionType.alboOro.rawValue, nameImage: MenuOptionType.alboOro.getNameImage()))
        self.dataSource.append((title: MenuOptionType.ranking.rawValue, nameImage: MenuOptionType.ranking.getNameImage()))
        self.dataSource.append((title: MenuOptionType.competizioni.rawValue, nameImage: MenuOptionType.competizioni.getNameImage()))
        self.dataSource.append((title: MenuOptionType.storia.rawValue, nameImage: MenuOptionType.storia.getNameImage()))
    }
    
    // MARK: LongPressGesture & Drag&Drop
    
    private func loadLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HomeVC.dragDropGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func dragDropGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case .ended:
            self.collectionView.endInteractiveMovement()
            
        default:
            self.collectionView.cancelInteractiveMovement()
        }
    }
    
    private func goToVCfromType(menuOption: MenuOptionType) {
        switch menuOption {
            
        case .alboOro:
            let storyboard = UIStoryboard(name: "AlboOro", bundle: nil)
            if let alboOroMenuVC = storyboard.instantiateViewController(withIdentifier: "AlboOroMenuVCID") as? AlboOroMenuVC {
                self.navigationController?.pushViewController(alboOroMenuVC, animated: true)
            }
            
        case .competizioni:
            let storyboard = UIStoryboard(name: "Competizioni", bundle: nil)
            if let competizioniMenuVC = storyboard.instantiateViewController(withIdentifier: "CompetizioniMenuVCID") as? CompetizioniMenuVC {
                self.navigationController?.pushViewController(competizioniMenuVC, animated: true)
            }
            
        case .ranking:
            let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
            if let rankingMenuVC = storyboard.instantiateViewController(withIdentifier: "RankingMenuVCID") as? RankingMenuVC {
                self.navigationController?.pushViewController(rankingMenuVC, animated: true)
            }
            
        case .storia:
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
        
        let constantWidth = (1 / 5) * view.frame.width
        let availableWidth = view.frame.width - constantWidth
        let widthPerItem = availableWidth / 2
        
        return CGSize(width: widthPerItem, height: HomeCell.getHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let constantWidth = (4 / 5) * view.frame.width
        let availableWidth = view.frame.width - constantWidth
        let widthPerItem = availableWidth / 3
        
        return UIEdgeInsets(top: 50.0, left: widthPerItem, bottom: 20.0, right: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let menuOption = MenuOptionType(rawValue: self.dataSource[indexPath.row].title) {
            self.goToVCfromType(menuOption: menuOption)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
    
    // DRAG & DROP
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let firstTemp = self.dataSource[sourceIndexPath.item]
        self.dataSource[sourceIndexPath.item] = self.dataSource[destinationIndexPath.item]
        self.dataSource[destinationIndexPath.item] = firstTemp
    }
}
