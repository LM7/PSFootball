//
//  SignUpVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions

    @IBAction func newAccountButtonAction(_ sender: Any) {
        guard
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else { return }
        
        FirebaseManager.createUser(email: email, password: password, success: { (user: Any) in
            if let userCurr = user as? User {
                DManager.user = userCurr
                self.performSegue(withIdentifier: "StartVCSegueID", sender: self)
            }
        }) { (error: Error) in
            print(error)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        self
    }
}
