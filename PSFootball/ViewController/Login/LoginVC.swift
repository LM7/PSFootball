//
//  LoginVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTextField()
        self.loadVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Functions
    
    private func loadTextField() {
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    private func loadVideo() {
        VideoManager.getVideoWithAudio(view: self.view, nameVideo: "trailerFifa19")
    }
    
    // MARK: Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        guard
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else { return }
        
        Loading?.show()
        
        FirebaseManager.login(email: email, password: password, success: { (user: Any) in
            if let userCurr = user as? User {
                
                Loading?.stop()
                
                DManager.user = userCurr
                VideoManager.pause()
                
                self.performSegue(withIdentifier: "StartVCSegueID", sender: self)
            }
        }) { (error: Error) in
            Loading?.stop()
            
            AlertView.showAlert(alertType: .error, message: error.localizedDescription)
        }
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCID") as? SignUpVC {
            vc.signUpVCDelegate = self
            
            self.present(vc, animated: true) {
                VideoManager.pause()
            }
        }
    }
}

extension LoginVC: SignUpVCDelegate {
    func signUpSuccess() {
        self.performSegue(withIdentifier: "StartVCSegueID", sender: self)
    }
}
