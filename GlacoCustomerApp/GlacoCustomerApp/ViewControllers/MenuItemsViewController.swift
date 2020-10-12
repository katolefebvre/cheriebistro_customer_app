//
//  MenuItemsViewController.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-29.
//

import UIKit

class MenuItemsViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    var categoryId: Int!
    var categoryName: String!
    var items: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNameLbl.text = categoryName
        items = DatabaseAccess.getMenuItemsForCategory(categoryId: categoryId)
        itemsTableView.backgroundColor = .darkGray
        itemsTableView.rowHeight = 80
        
        if items.count == 0 {
            let emptyItemsAlertController = UIAlertController(title: "No Items Available", message: "No items for this category are available at this time.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { alertAction in
                self.performSegue(withIdentifier: "doUnwindToCategories", sender: self)
            }
            emptyItemsAlertController.addAction(cancelAction)
            self.present(emptyItemsAlertController, animated: true)
        }
    }
    
    @IBAction func doUnwind(segue:UIStoryboardSegue) {
    }
    
    @IBAction func unwindFromModal(segue:UIStoryboardSegue) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cartModalViewController = segue.destination as? CartModalViewController,
              let index = itemsTableView.indexPathForSelectedRow?.row
        else {
            return
        }
        cartModalViewController.menuItem = items[index]
    }
}
