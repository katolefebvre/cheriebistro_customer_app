//
//  MenuViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-26.
//

import UIKit

class MenuCategoriesViewController: UIViewController {
    
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
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        menuCategories = DatabaseAccess.getCategories()
        
        view.addSubview(menuCollectionView)
        menuCollectionView.backgroundColor = .darkGray
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
}

extension MenuCategoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCollectionViewCell
        cell.category = menuCategories[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 10
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
        return CGSize(width: menuCollectionView.frame.width, height: menuCollectionView.frame.height/7.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "MenuItemsViewController") as! MenuItemsViewController
        controller.categoryId = menuCategories[indexPath.row].id
        controller.categoryName = menuCategories[indexPath.row].name
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
