//
//  DatabaseIdTableViewCell.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-27.
//

import UIKit

/// A custom TableViewCell that stores a database ID as a parameter to be accessed by anyone.
class DatabaseIdTableViewCell: UITableViewCell {
    
    public var databaseId : Int?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
