//
//  MenuItemCollectionViewCell.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    
    public var category : Category?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure() {
        itemNameLbl.text = category?.name
        bgImageView.image = UIImage(named: "burger.jpg")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
    }
}
