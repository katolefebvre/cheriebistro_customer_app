//
//  CurrentOrderViewController.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-08.
//

import UIKit

class CurrentOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

        @IBOutlet var tableView : UITableView!
        @IBOutlet var noItemsMsg : UILabel!
        @IBOutlet var totalPriceLbl : UILabel!
        @IBOutlet var taxLbl : UILabel!
        @IBOutlet var totalWithTaxLbl : UILabel!
        
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
            tableCell.itemName.text = mainDelegate.tableOrder.items[indexPath.row].menuItem.name
            tableCell.itemDesc.text = mainDelegate.tableOrder.items[indexPath.row].menuItem.description
            tableCell.removeButton.tag = indexPath.row
            tableCell.parentDelegate = self
            tableCell.backgroundColor = .white
            
            tableCell.itemPrice.text = currencyFormatter.string(from: NSNumber(value: mainDelegate.tableOrder.items[indexPath.row].menuItem.price))!
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
            if mainDelegate.tableOrder?.items.isEmpty ?? true{
                noItemsMsg.isHidden = false
            }
            else{
                noItemsMsg.isHidden = true
            }
        }
        
        @IBAction func unwindFromModal(segue:UIStoryboardSegue) {
            updateNoItemMsg()
            updateTotal()
        }
    
        func updateTotal(){
            var total : Float = 0.0
            var tax : Float = 0.0
            //totalWithTaxLbl.text = currencyFormatter.string(from: NSNumber(value: 0))
            if !(mainDelegate.tableOrder?.items.isEmpty ?? true){
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

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    
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
    }

    protocol ParentControllerDelegate{
    func requestReloadTable()
    }

    extension CurrentOrderViewController: ParentControllerDelegate{
        func requestReloadTable() {
            self.tableView.reloadData()
            updateNoItemMsg()
            updateTotal()
        }
}

