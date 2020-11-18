//
//  OrderTableViewCell.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-11-17.
//

import UIKit

class OrderHistoryViewCell: UITableViewCell {

    @IBOutlet var itemName : UILabel!
    @IBOutlet var itemCost : UILabel!
    @IBOutlet var itemDesc : UILabel!
    @IBOutlet var specialInstructions : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
