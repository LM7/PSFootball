//
//  LoginVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication
import Crashlytics

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTextField()
        self.loadVideo()
        self.loadGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PSFootballHelper.trackAnswers(withName: "LoginVC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TOUCH ID
    
    private func authenticationUserTouchID() {
        
        let context = LAContext()
        var error: NSError?
        
        //check Touch Id
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Autenticazione con Touch ID"
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (isSuccess, error) in
                
                if
                    isSuccess,
                    let email = PSFootballHelper.getFromKeychain(key: "email"),
                    let password = PSFootballHelper.getFromKeychain(key: "password") {
                    
                    print("Success Touch ID")
                    self.callLoginFirebase(email: email, password: password)
                    
                } else {
                    print("Failure Touch ID")
                    AlertView.showAlert(alertType: AlertType.error, message: "Impronta non riconosciuta")
                }
            }
        }
    }
    
    // MARK: Private Functions
    
    private func callLoginFirebase(email: String, password: String) {
        Loading?.show()
        
        FirebaseManager.login(email: email, password: password, success: { (user: Any) in
            if let _ = user as? User {
                
                Loading?.stop()
                
                let psUser = CoreDataHelper.fetchInsertPSUser(email: email)
                
                psUser?.email = email
                psUser?.password = password
                
                DManager.user = psUser
                cdmPSF.saveMainMOC()
                
                VideoManager.pause()
                
                self.dismissEverything()
                self.performSegue(withIdentifier: "StartVCSegueID", sender: self)
            }
        }) { (error: Error) in
            Loading?.stop()
            AlertView.showAlert(alertType: .error, message: error.localizedDescription)
        }
    }
    
    private func loadTextField() {
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    private func loadVideo() {
        VideoManager.getVideoWithAudio(view: self.view, nameVideo: "trailerFifa19")
    }
    
    private func loadGesture() {
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(self.dismissEverything))
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    @objc func dismissEverything() {
        self.view.endEditing(true)
    }
    
    // MARK: Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        guard
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else { return }
        
        self.callLoginFirebase(email: email, password: password)
    }
    
    @IBAction func loginTouchIDAction(_ sender: Any) {
        self.authenticationUserTouchID()
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

// MARK: SignUpVCDelegate

extension LoginVC: SignUpVCDelegate {
    func signUpSuccess() {
        self.dismissEverything()
        self.performSegue(withIdentifier: "StartVCSegueID", sender: self)
    }
}
