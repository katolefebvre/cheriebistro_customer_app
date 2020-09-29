//
//  MenuItemCollectionViewCell.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-27.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    
    public var itemId : Int?
    public var itemName : String?
    public var item : MenuItem?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure() {
        itemNameLbl.text = itemName
        bgImageView.image = UIImage(named: "burger.jpg")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
    }
}
