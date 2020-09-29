//
//  MenuItemsViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-29.
//

import UIKit

class MenuItemsViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    var categoryId: Int!
    var items: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = DatabaseAccess.getMenuItemsForCategory(categoryId: categoryId)
        itemsTableView.backgroundColor = .darkGray
        itemsTableView.rowHeight = 100
        
        if items.count == 0 {
            let emptyItemsAlertController = UIAlertController(title: "No Items Available", message: "No items for this category were found.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            emptyItemsAlertController.addAction(cancelAction)
            self.present(emptyItemsAlertController, animated: true)
        }
    }
}

extension MenuItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! MenuItemTableViewCell
        cell.item = items[indexPath.row]
        cell.configure()
        return cell
    }
}
