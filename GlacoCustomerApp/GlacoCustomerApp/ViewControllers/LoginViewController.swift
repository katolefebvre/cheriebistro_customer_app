//
//  LoginViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-26.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var employeeIdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tablesList: UITableView!
    let tableSections : Int = 1
    
    var availableTables : [Table] = []
    var chosenTableID : String = ""
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablesList.delegate = self
        tablesList.dataSource = self
        
        availableTables = DatabaseAccess.getAvailableTables()
        tablesList.reloadData()
        
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
        
        let employeeId = employeeIdTextField.text!;
        if employeeId.isEmpty {
            return
        }
        
        if chosenTableID.isEmpty {
            return
        }
        
        let foundTable = DatabaseAccess.registerTable(tableId: chosenTableID, employeeId: employeeId)
        if foundTable.1 == "" {
            mainDelegate.loggedTable = foundTable.0
            mainDelegate.tableOrder = TableOrder(tableId: foundTable.0!.id)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginView", sender: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: foundTable.1, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
            
            tablesList.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") ?? UITableViewCell()
        let index = indexPath.row
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemBlue
        cell.selectedBackgroundView = backgroundView
        
        cell.textLabel?.text = "Table \(availableTables[index].id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        chosenTableID = availableTables[index].id
    }
    
}
