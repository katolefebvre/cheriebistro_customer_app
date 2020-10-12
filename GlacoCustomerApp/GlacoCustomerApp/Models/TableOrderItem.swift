//
//  TableOrderItem.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-12.
//

import UIKit

class TableOrderItem: NSObject {

    var menuItem : MenuItem!
    var itemModifications : String
    var quantity : Int
    
    init(menuItem: MenuItem, itemModifications : String, quantity: Int) {
        self.menuItem = menuItem
        self.itemModifications = itemModifications
        self.quantity = quantity
    }
}
