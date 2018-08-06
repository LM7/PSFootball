//
//  StartVC.swift
//  PSFootball
//
//  Created by Lorenzo on 08/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import UIKit
import Firebase

class StartVC: UIViewController {

    @IBOutlet weak var benvenutoLabel: UILabel!
    @IBOutlet weak var aggiornaUsernameLabel: UILabel!
    @IBOutlet weak var aggiornaUsernameTextField: UITextField!
    @IBOutlet weak var avantiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadGesture()
        self.loadGraphic()
        
        self.aggiornaUsernameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PSFootballHelper.trackAnswers(withName: "StartVC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Functions
    
    private func setUsername() {
        guard let username = self.aggiornaUsernameTextField.text, !username.isEmpty else { return }
        
        let refUserUID = FirebaseManager.getReferenceDBUserUID()
        let usernameDict = ["USERNAME".localized : "\(username)"]
        
        //UPDATE
        if let psUser = DManager.user?.username, !psUser.isEmpty {
            refUserUID?.updateChildValues(usernameDict)
        } else { //INSERT
            refUserUID?.setValue(usernameDict)
        }
        
        DManager.user?.username = username
        cdmPSF.saveMainMOC()
    }
    
    private func loadGraphic() {
        if let psUser = DManager.user?.username, !psUser.isEmpty {
            self.benvenutoLabel.text = "Ciao \(psUser)"
            self.aggiornaUsernameLabel.text = "Puoi aggiornare il tuo username"
            self.enableDisableAvanti(isEnabled: true)
            
        } else {
            self.benvenutoLabel.text = "BENVENUTO"
            self.aggiornaUsernameLabel.text = "Inserisci il tuo username"
            self.enableDisableAvanti(isEnabled: false)
        }
    }
    
    private func enableDisableAvanti(isEnabled: Bool) {
        self.avantiButton.isEnabled = isEnabled
        let colorButton = (isEnabled) ? UIColor.white : UIColor.gray
        self.avantiButton.setTitleColor(colorButton, for: UIControlState.normal)
    }
    
    private func loadGesture() {
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(self.dismissEverything))
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    @objc func dismissEverything() {
        self.view.endEditing(true)
    }
    
    // MARK: Actions

    @IBAction func avantiButtonAction(_ sender: Any) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboardMain.instantiateViewController(withIdentifier: "HomeVCID") as? HomeVC {
            
            self.setUsername()
            self.dismissEverything()
            
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        self.dismissEverything()
        VideoManager.resume()
        
        do {
            try FirebaseManager.logout()
            
        } catch let error {
            print(error.localizedDescription)
            AlertView.showAlert(alertType: AlertType.error, message: "Logout Error")
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UITextFieldDelegate

extension StartVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var textFinal = ""
        
        if let textCurr = textField.text as NSString? {
            textFinal = textCurr.replacingCharacters(in: range, with: string)
        }
        if let psUser = DManager.user?.username, !psUser.isEmpty {
            //NOP
        } else {
            self.enableDisableAvanti(isEnabled: textFinal.count > 0)
        }
        return true
    }
}
