//
//  CompetizioniMenuVC.swift
//  PSFootball
//
//  Created by Lorenzo on 06/07/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit

class CompetizioniMenuVC: BaseVC {
    
    override var titleNav: String? {
        get { return "COMPETIZIONI MENU" }
        set {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PSFootballHelper.trackAnswers(withName: "CompetizioniMenuVC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
