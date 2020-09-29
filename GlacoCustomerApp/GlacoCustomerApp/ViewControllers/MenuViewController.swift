//
//  MenuViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-26.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "category")
        return cv
    }()
    
    var menuCategories : [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        menuCategories = DatabaseAccess.getCategories()
        
        view.addSubview(menuCollectionView)
        menuCollectionView.backgroundColor = .darkGray
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCollectionViewCell
        cell.category = menuCategories[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.backgroundColor = UIColor.white.cgColor
        
        cell.configure()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuCollectionView.frame.width/4.2, height: menuCollectionView.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "MenuItemsViewController") as! MenuItemsViewController
        controller.categoryId = menuCategories[indexPath.row].id
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuCategories.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : DatabaseIdTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "category") as? DatabaseIdTableViewCell ?? DatabaseIdTableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "category")
//
//        let cellBackgroundView = UIView()
//        cellBackgroundView.backgroundColor = .systemBlue
//
//        cell?.textLabel?.font = UIFont.systemFont(ofSize: 24)
//        cell?.textLabel?.text = menuCategories[indexPath.row].name
//        cell?.databaseId = (Int)(menuCategories[indexPath.row].id)
//        cell?.backgroundColor = .darkGray
//        cell?.textLabel?.textColor = .white
//        cell?.selectedBackgroundView = cellBackgroundView
//
//        return cell!
//    }
//}
