//
//  ShoppingCartViewController.swift
//  GlacoCustomerApp
//
//  Created by Karl Galinski on 2020-09-29.
//

import UIKit

class ShoppingCartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var noItemsMsg : UILabel!
    @IBOutlet var totalPrice : UILabel!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let currencyFormatter = NumberFormatter()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.ShoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShoppingCartTableViewCell ?? ShoppingCartTableViewCell(style: .default, reuseIdentifier: "cell")
        tableCell.itemName.text = mainDelegate.ShoppingCart[indexPath.row].name
        tableCell.itemDesc.text = mainDelegate.ShoppingCart[indexPath.row].description
        tableCell.removeButton.tag = indexPath.row
        tableCell.parentDelegate = self
        
        
        
        tableCell.itemPrice.text = currencyFormatter.string(from: NSNumber(value: mainDelegate.ShoppingCart[indexPath.row].price))!
        tableCell.backgroundColor = .clear
        return tableCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        
        updateNoItemMsg()
        updateTotal()
        // Do any additional setup after loading the view.
    }
    
    func updateNoItemMsg(){
        if mainDelegate.ShoppingCart.isEmpty{
            noItemsMsg.isHidden = false
        }
        else{
            noItemsMsg.isHidden = true
        }
    }
    
    func updateTotal(){
        var total : Float = 0.0
        for item in mainDelegate.ShoppingCart{
            total += item.price
        }
        totalPrice.text = currencyFormatter.string(from: NSNumber(value: total))!
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

protocol ParentControllerDelegate{
func requestReloadTable()
}

extension ShoppingCartViewController: ParentControllerDelegate{
    func requestReloadTable() {
        self.tableView.reloadData()
        updateNoItemMsg()
        updateTotal()
    }
}
