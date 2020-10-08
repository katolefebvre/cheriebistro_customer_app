//
//  MenuItemTableViewCell.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-29.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    public var item : MenuItem!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure() {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        
        itemTitleLbl.text = item!.name
        itemPriceLbl.text = currencyFormatter.string(from: NSNumber(value: item!.price))!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
