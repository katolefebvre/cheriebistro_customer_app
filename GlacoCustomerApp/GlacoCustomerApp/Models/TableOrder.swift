//
//  TableOrder.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-12.
//

import UIKit

class TableOrder: NSObject {
    var tableId : Int
    var status : String
    var items : [TableOrderItem]
    var totalWithTax: Float
    
    init(tableId : Int) {
        self.tableId = tableId
        self.status = "Not Submitted"
        self.items = []
        self.totalWithTax = 0
    }
    
    func updateTotalWithTax(){
        totalWithTax = 0
        for item in items{
            totalWithTax += item.menuItem.price * 1.13
        }
    }
}
