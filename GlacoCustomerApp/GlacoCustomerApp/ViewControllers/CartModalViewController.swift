//
//  CartModalViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-10-07.
//

import UIKit

class CartModalViewController: UIViewController {

    public var menuItem: MenuItem?
    
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var specialInstrucTxtField: UITextField!
    @IBOutlet weak var qtyStepper: UIStepper!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        qtyStepper.wraps = true
        qtyStepper.autorepeat = true
        qtyStepper.maximumValue = 10

        
        itemTitleLbl.text = menuItem?.name
        itemDescLbl.text = menuItem?.description
        itemPriceLbl.text = currencyFormatter.string(from: NSNumber(value: menuItem?.price ?? 0))
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        qtyLbl.text = Int(sender.value).description
    }
    
}
