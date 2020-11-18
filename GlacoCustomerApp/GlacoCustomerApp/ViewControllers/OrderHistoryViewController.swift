//
//  OrderHistoryViewController.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-11-17.
//

import UIKit

class OrderHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let currencyFormatter = NumberFormatter()
    @IBOutlet var tableView : UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.orderHistory[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "order") as? OrderHistoryViewCell ?? OrderHistoryViewCell(style: .default, reuseIdentifier: "order")
        let quantity = mainDelegate.orderHistory[indexPath.section].items[indexPath.row].quantity
        let price = mainDelegate.orderHistory[indexPath.section].items[indexPath.row].menuItem.price
        tableCell.itemName.text = "\(mainDelegate.orderHistory[indexPath.section].items[indexPath.row].menuItem.name) x \(quantity)"
        tableCell.itemDesc.text = mainDelegate.orderHistory[indexPath.section].items[indexPath.row].menuItem.description
        tableCell.backgroundColor = .white
        tableCell.itemCost.text = "\(currencyFormatter.string(from: NSNumber(value: price))!) x\(quantity)       \(currencyFormatter.string(from: NSNumber(value: price * Float(quantity)))!)"
        let specialInstructions = mainDelegate.orderHistory[indexPath.section].items[indexPath.row].specialInstructions
        if specialInstructions.isEmpty {
            tableCell.specialInstructions.text = "Special Instructions: None"
        }
        else{
            tableCell.specialInstructions.text = "Special Instructions: \(specialInstructions)"
        }
        
        return tableCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainDelegate.orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.setTitle("Order \(section+1)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        return button
    }
    
    //Neccessary to override the width of the table row to fit all infromation.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
