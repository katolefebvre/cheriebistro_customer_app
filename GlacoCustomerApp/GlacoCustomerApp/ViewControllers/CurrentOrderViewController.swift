//
//  CurrentOrderViewController.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-08.
//

import UIKit

class CurrentOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var noItemsMsg : UILabel!
    @IBOutlet var totalPriceLbl : UILabel!
    @IBOutlet var taxLbl : UILabel!
    @IBOutlet var totalWithTaxLbl : UILabel!
    @IBOutlet var submitOrderButton : UIButton!
    @IBOutlet var orderHistoryButton : UIButton!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let currencyFormatter = NumberFormatter()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.tableOrder.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CurrentOrderTableViewCell ?? CurrentOrderTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let quantity = mainDelegate.tableOrder.items[indexPath.row].quantity.description
        let price = mainDelegate.tableOrder.items[indexPath.row].menuItem.price
        tableCell.itemName.text = mainDelegate.tableOrder.items[indexPath.row].menuItem.name + " x" + quantity
        tableCell.itemDesc.text = "Tap here to view and edit details."
        tableCell.removeButton.tag = indexPath.row
        tableCell.parentDelegate = self
        tableCell.backgroundColor = .white
        tableCell.itemPrice.text = currencyFormatter.string(from: NSNumber(value: price))! + " x" + quantity + "    " + currencyFormatter.string(from: NSNumber(value: price * Float(quantity)!))!
        return tableCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        
        submitOrderButton.setTitleColor(.lightGray, for: .disabled)
        orderHistoryButton.setTitleColor(.lightGray, for: .disabled)
        
        updateNoItemMsg()
        updateTotal()
        updateSubmitButton()
    }
    
    func updateNoItemMsg(){
        if mainDelegate.tableOrder?.items.isEmpty ?? true{
            noItemsMsg.isHidden = false //if order empty no item message shown (not hidden)
        }
        else{
            noItemsMsg.isHidden = true
        }
    }
    
    @IBAction func addOrderButtonPressed(_ sender: Any) {
        
        let orderToSave = self.mainDelegate.tableOrder
        if orderToSave == nil || orderToSave!.items.count == 0 {
            let alert = UIAlertController(title: "Success", message: "Order submitted, please wait for a server!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let addAlert = UIAlertController(title: "Send Order", message: "Do you want to send the order?", preferredStyle: UIAlertController.Style.alert)
            
            addAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action: UIAlertAction!) in
                let result = DatabaseAccess.addOrder(order: orderToSave!)
                if result == 0 {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Order not sent", message: "try again!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    for item in orderToSave!.items {
                        _ = DatabaseAccess.addOrderItem(item: item, orderID: result!)
                    }
                    self.mainDelegate.orderHistory.append(orderToSave!)
                    self.mainDelegate.tableOrder = TableOrder(tableId: self.mainDelegate.loggedTable!.id)
                    self.requestReloadTable()
                    let alert = UIAlertController(title: "Success", message: "Order submitted, please wait for a server!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }))
            
            addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(addAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromModal(segue:UIStoryboardSegue) {
        updateNoItemMsg()
        updateTotal()
        updateSubmitButton()
        tableView.reloadData()
    }
    
    func updateTotal(){
        var total : Float = 0.0
        var tax : Float = 0.0
       
        if !(mainDelegate.tableOrder?.items.isEmpty ?? true){ // if order is not empty
            for item in mainDelegate.tableOrder!.items{
                total += item.menuItem.price * Float(item.quantity)
                tax += item.menuItem.price * Float(item.quantity) * 0.13
            }
        }
        mainDelegate.tableOrder.updateTotalWithTax()
        totalWithTaxLbl.text = currencyFormatter.string(from: NSNumber(value: mainDelegate.tableOrder.totalWithTax))!
        totalPriceLbl.text = currencyFormatter.string(from: NSNumber(value: total))!
        taxLbl.text = currencyFormatter.string(from: NSNumber(value: tax))!
    }
    
    func updateSubmitButton(){
        if mainDelegate.tableOrder.items.isEmpty{
            submitOrderButton.isEnabled = false
        }
        else{
            submitOrderButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cartModalViewController = segue.destination as? CartModalViewController,
              let index = tableView.indexPathForSelectedRow?.row
        else {
            return
        }
        cartModalViewController.menuItem = mainDelegate.tableOrder.items[index].menuItem
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "orderToCartModal", sender: self)
    }
    
    func updateOrderHistoryButton(){
        if mainDelegate.orderHistory.count < 1 {
            orderHistoryButton.isEnabled = false
        }
        else {
            orderHistoryButton.isEnabled = true
        }
    }
}

protocol ParentControllerDelegate{
    func requestReloadTable()
}

extension CurrentOrderViewController: ParentControllerDelegate{
    func requestReloadTable() {
        self.tableView.reloadData()
        updateNoItemMsg()
        updateTotal()
        updateSubmitButton()
        updateOrderHistoryButton()
    }
}

