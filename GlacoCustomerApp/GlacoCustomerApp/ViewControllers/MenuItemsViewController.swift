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
        items = DatabaseAccess.getMenuItems()
        
        itemsTableView.backgroundColor = .darkGray
        itemsTableView.rowHeight = 100
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
