//
//  StoriaClubMenuVC.swift
//  PSFootball
//
//  Created by Lorenzo on 06/07/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class StoriaClubMenuVC: BaseVC {
    
    override var titleNav: String? {
        get { return "STORIA DEI CLUB MENU" }
        set {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PSFootballHelper.trackAnswers(withName: "StoriaClubMenuVC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
