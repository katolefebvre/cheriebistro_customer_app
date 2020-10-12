//
//  TableOrderItem.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-12.
//

import UIKit

class TableOrderItem: NSObject {

    var menuItem : MenuItem!
    var specialInstructions : String
    var quantity : Int
    
    init(menuItem: MenuItem, itemModifications : String, quantity: Int) {
        self.menuItem = menuItem
        self.specialInstructions = itemModifications
        self.quantity = quantity
    }
}
