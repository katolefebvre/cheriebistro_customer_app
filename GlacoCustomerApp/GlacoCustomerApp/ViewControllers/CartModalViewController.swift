//
//  CartModalViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-10-07.
//

import UIKit

class CartModalViewController: UIViewController {

    public var menuItem: MenuItem!
    
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var specialInstrucTxtField: UITextField!
    @IBOutlet weak var qtyStepper: UIStepper!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        
        qtyStepper.value = 1
        qtyStepper.wraps = false
        qtyStepper.autorepeat = true
        qtyStepper.maximumValue = 10

        
        itemTitleLbl.text = menuItem?.name
        itemDescLbl.text = menuItem?.description
//        if let found = (mainDelegate.tableOrder.items.contains(where: {$0.menuItem.id == menuItem.id})){
//            specialInstrucTxtField.text =
//        }
        
        if let found = mainDelegate.tableOrder.items.first(where: {$0.menuItem.id == menuItem.id}){
            specialInstrucTxtField.text = found.specialInstructions
            qtyStepper.value = Double(found.quantity)
            qtyLbl.text = Int(qtyStepper.value).description
            }
        itemPriceLbl.text = currencyFormatter.string(from: NSNumber(value: menuItem?.price ?? 0))
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        qtyLbl.text = Int(sender.value).description
    }
    
    @IBAction func updateOrder(_ sender: UIButton){
        if let found = mainDelegate.tableOrder.items.first(where: {$0.menuItem.id == menuItem.id}){
            found.quantity = Int(qtyStepper.value)
            found.specialInstructions = specialInstrucTxtField.text ?? ""
        }
        else{
            if qtyStepper.value > 0{
                mainDelegate.tableOrder?.items.append(TableOrderItem(menuItem: menuItem!, itemModifications: specialInstrucTxtField.text ?? "", quantity: Int(qtyStepper!.value)))
            }
        }
        self.performSegue(withIdentifier: "unwindFromModal", sender: self)
    }
}
