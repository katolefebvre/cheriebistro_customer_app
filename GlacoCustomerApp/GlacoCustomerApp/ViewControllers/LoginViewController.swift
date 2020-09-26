//
//  LoginViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-26.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableIdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.isEnabled = false
    }
    
    @IBAction func onIdTextFieldChange(_ sender: Any) {
        let checkString : String = (tableIdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        if checkString.isEmpty {
            loginBtn.isEnabled = false
        }
        else {
            loginBtn.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 10
    }
    
    @IBAction func loginBtnPressed(_ sender: AnyObject) {
        
        let tableId = tableIdTextField.text;
        
        if tableId!.isEmpty {
            return
        }
        
        if let foundTable = DatabaseAccess.loginTable(loginId: tableId!) {
            
            mainDelegate.loggedTable = foundTable
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginView", sender: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Invalid Table ID", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        
        tableIdTextField.text = ""
        loginBtn.isEnabled = false

    }
}
