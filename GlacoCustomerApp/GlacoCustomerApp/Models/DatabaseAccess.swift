//
//  DatabaseAccess.swift
//  GlacoCustomerApp
//
//  Created by Kato Lefebvre on 2020-09-23
//  Copyright © 2020 GLAC Co. All rights reserved.
//

import Foundation
import UIKit

/// Represents the connection between the application and the PHP API.
class DatabaseAccess {
    
    let mainDelegate = UIApplication.shared.delegate
    
    /// Retrieves all of the TimeSlots stored in the database and returns them.
    class func getTimeSlots() -> [TimeSlot] {
        var results : [TimeSlot] = []
        let url = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/gettimeslots.php")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error")
                return
            }
            
            do {
                var timeslotJSON : NSDictionary!
                timeslotJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let timeslotArray : NSArray = timeslotJSON["time_slots"] as! NSArray
                
                for timeslot in timeslotArray {
                    if let ts = timeslot as? [String : Any] {
                        results.append(TimeSlot(id: Int(ts["id"]! as! String)!, name: ts["name"]! as! String))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return results
    }
    
    /// Retrieves all of the Categories stored in the database and returns them.
    class func getCategories() -> [Category] {
        var results : [Category] = []
        let url = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/getcategories.php")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error")
                return
            }
            
            do {
                var categoryJSON : NSDictionary!
                categoryJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let categoryArray : NSArray = categoryJSON["categories"] as! NSArray
                
                for category in categoryArray {
                    if let c = category as? [String : Any] {
                        results.append(Category(id: Int(c["id"]! as! String)!, name: c["name"]! as! String))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return results
    }
    
    
    /// Retrieves all of the MenuItems stored in the database and returns them.
    class func getMenuItems() -> [MenuItem] {
        var results: [MenuItem] = []
        let url = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/getmenuitems.php")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error")
                return
            }
            
            do {
                var menuitemJSON : NSDictionary!
                menuitemJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let menuitemArray : NSArray = menuitemJSON["menu_items"] as! NSArray
                
                for menuitem in menuitemArray {
                    if let mi = menuitem as? [String : Any] {
                        results.append(MenuItem(
                            id: Int(mi["id"]! as! String)!,
                            name: mi["name"]! as! String,
                            description: mi["description"]! as! String,
                            price: Float(mi["price"]! as! String)!,
                            timeslot: TimeSlot(
                                id: Int(mi["time_slot_id"]! as! String)!,
                                name: "Sunrise Breakfast" // hard coded for now
                            )
                        ))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return results
    }
    
    /// Retrieves all of the MenuItems for a specific Category stored in the database and returns them.
    class func getMenuItemsForCategory(categoryId: Int) -> [MenuItem] {
        var results: [MenuItem] = []
        let url = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/getmenuitemsforcategory.php?categoryId=\(categoryId)")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error")
                return
            }
            
            do {
                var menuitemJSON : NSDictionary!
                menuitemJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let menuitemArray : NSArray = menuitemJSON["menu_items"] as! NSArray
                
                for menuitem in menuitemArray {
                    if let mi = menuitem as? [String : Any] {
                        results.append(MenuItem(
                            id: Int(mi["id"]! as! String)!,
                            name: mi["name"]! as! String,
                            description: mi["description"]! as! String,
                            price: Float(mi["price"]! as! String)!,
                            timeslot: TimeSlot(
                                id: Int(mi["time_slot_id"]! as! String)!,
                                name: "Sunrise Breakfast" // hard coded for now
                            )
                        ))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return results
    }
    
    /// Retrieves the Table information stored in the database for a particular Table and returns it if the Table exists.
    /// - Parameters:
    ///   - tableId: The ID of the table to register
    ///   - employeeId: The ID of the employee to register
    /// - Returns: Tuple of the successfully registered Table and a String error message (if applicable)
    class func registerTable(tableId: String, employeeId : String) -> (Table?, String) {
        var tableResult: (Table?, String) = (nil, "")
        let myUrl = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/loginTable.php")!
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value: 0)

        var postString = "tableID=\(tableId)"
        postString = postString + "&employeeID=\(employeeId)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error")
                semaphore.signal()
                return
            }
            do {
                var LoginJSON: NSDictionary!
                LoginJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary

                if let parseJSON = LoginJSON {
                    let response: String = parseJSON["status"] as! String
                    print("result: \(response)")

                    if response == "Success" {
                        tableResult = (Table(id: tableId, employeeId: employeeId), "")
                    } else {
                        tableResult.1 = parseJSON["message"] as! String
                    }
                } else {
                    return
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return tableResult
    }
    
    
    /// Obtains all the available tables in the database (not currently in use by an employee)
    /// - Returns: An array of all tables with no associated Employee ID
    class func getAvailableTables() -> [Table] {
        var tables : [Table] = []
        let url = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/getAvailableTables.php")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error")
                return
            }
            
            do {
                var tableJSON : NSDictionary!
                tableJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let tablesArray : NSArray = tableJSON["tables"] as! NSArray
                
                for table in tablesArray {
                    if let t = table as? [String : Any] {
                        tables.append(Table(id: t["tableID"]! as! String, employeeId : ""))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return tables
    }
    
    
    /// Adds order to the database
    /// - Parameter order: The order to be saved
    /// - Returns: The ID of the order saved to the database
    class func addOrder(order : TableOrder) -> Int? {
        var result : Int?

        let address = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/addOrder.php")!
        let request = NSMutableURLRequest(url: address)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value: 0)

        var dataString = "table_id=\(order.tableId)"
        dataString = dataString + "&price_total=\(order.totalWithTax)"
        dataString = dataString + "&status=Pending"
        
        request.httpBody = dataString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error")
                semaphore.signal()
                return
            }
            do {
                var orderJSON: NSDictionary!
                orderJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary

                if let parseJSON = orderJSON {
                    let error: String = parseJSON["error"] as! String

                    if error == "false" {
                        result = Int(parseJSON["addedId"] as! String) ?? 0
                    }
                } else {
                    return
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    
    class func addOrderItem(item : TableOrderItem, orderID : Int) -> [String : String] {
        var results : [String : String] = [:]

        let address = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/addOrderItem.php")!
        let url = NSMutableURLRequest(url: address)
        url.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value: 0)

        var dataString = "menu_item_id=\(item.menuItem.id)"
        dataString = dataString + "&item_modification=\(item.specialInstructions)"
        dataString = dataString + "&quantity=\(item.quantity)"
        dataString = dataString + "&order_id=\(orderID)"

        let dataD = dataString.data(using: .utf8)

        do {
           let uploadJob = URLSession.shared.uploadTask(with: url as URLRequest, from: dataD) {
               data, response, error in
               if error != nil {
                   print(error!)
                   semaphore.signal()
                   return
               } else {
                if let unwrappedData = data{
                    
                       let jsonResponse = try! JSONSerialization.jsonObject(with: unwrappedData, options: [])
                       guard let jsonArray = jsonResponse as? [String: String] else {
                           semaphore.signal()
                           return
                       }
                    results = jsonArray
                   }
               }
               semaphore.signal()
           }
           uploadJob.resume()
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return results
    }
}
