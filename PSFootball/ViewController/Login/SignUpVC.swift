//
//  SignUpVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import Firebase

protocol SignUpVCDelegate: NSObjectProtocol {
    func signUpSuccess()
}

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var signUpVCDelegate: SignUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Functions
    
    private func loadTextField() {
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    // MARK: Actions

    @IBAction func newAccountButtonAction(_ sender: Any) {
        guard
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else { return }
        
        Loading?.show()
        
        FirebaseManager.createUser(email: email, password: password, success: { (user: Any) in
            if let userCurr = user as? User {
                
                Loading?.stop()
                
                DManager.user = userCurr
                
                self.dismiss(animated: true, completion: {
                    self.signUpVCDelegate?.signUpSuccess()
                })
            }
        }) { (error: Error) in
            Loading?.stop()
            AlertView.showAlert(alertType: .error, message: error.localizedDescription)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            VideoManager.resume()
        }
    }
}
