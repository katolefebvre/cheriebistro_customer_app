//
//  CurrentOrderTableViewCell.swift
//  GlacoCustomerApp
//
//  Created by Xcode User on 2020-10-08.
//

import UIKit

class CurrentOrderTableViewCell: UITableViewCell {

    let itemName = UILabel()
    let itemDesc = UILabel()
    let itemPrice = UILabel()
    let removeButton = UIButton()
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var parentDelegate: ParentControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        itemName.textAlignment = .left
        itemName.font = UIFont.boldSystemFont(ofSize: 25)
        itemName.backgroundColor = .clear
        itemName.textColor = .black
        
        itemDesc.textAlignment = .left
        itemDesc.font = UIFont.boldSystemFont(ofSize: 16)
        itemDesc.backgroundColor = .clear
        itemDesc.textColor = .black
        
        itemPrice.textAlignment = .left
        itemPrice.font = UIFont.boldSystemFont(ofSize: 16)
        itemPrice.backgroundColor = .clear
        itemPrice.textColor = .black
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        removeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(.systemRed, for: .normal)
        removeButton.showsTouchWhenHighlighted = true
        
        contentView.addSubview(itemName)
        contentView.addSubview(itemDesc)
        contentView.addSubview(itemPrice)
        contentView.addSubview(removeButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        mainDelegate.ShoppingCart.remove(at: sender.tag)
        self.parentDelegate?.requestReloadTable()
    }

    override func layoutSubviews() {
        itemName.frame = CGRect(x: 15, y:10, width: 280, height: 30)
        itemDesc.frame = CGRect(x: 305, y: 17, width: 830, height: 20)
        itemPrice.frame = CGRect(x: 1150, y: 17, width: 90, height: 20)
        removeButton.frame = CGRect(x: 1250, y: 10, width: 75, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
