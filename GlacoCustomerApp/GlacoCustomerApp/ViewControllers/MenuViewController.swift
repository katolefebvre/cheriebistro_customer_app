//
//  MenuViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-26.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuCategoriesTableView: UITableView!
    @IBOutlet weak var menuCollectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: "menuItem")
        return cv
    }()
    
    var menuItems : [MenuItem] = []
    var menuCategories : [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        menuItems = DatabaseAccess.getMenuItems()
        menuCategories = DatabaseAccess.getCategories()
        
        view.addSubview(menuCollectionView)
        menuCollectionView.backgroundColor = .white
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCategoriesTableView.delegate = self
        menuCategoriesTableView.dataSource = self
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuItem", for: indexPath) as! MenuItemCollectionViewCell
        cell.itemId = menuItems[indexPath.row].id
        cell.itemName = menuItems[indexPath.row].name
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.configure()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuCollectionView.frame.width/3.1, height: menuCollectionView.frame.height/2)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : DatabaseIdTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "category") as? DatabaseIdTableViewCell ?? DatabaseIdTableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "category")
                
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = .systemBlue
        
        tableCell?.textLabel?.font = UIFont.systemFont(ofSize: 24)
        tableCell?.textLabel?.text = menuCategories[indexPath.row].name
        tableCell?.databaseId = (Int)(menuCategories[indexPath.row].id)
        tableCell?.selectedBackgroundView = cellBackgroundView
        
        return tableCell!
    }
    
    
}
