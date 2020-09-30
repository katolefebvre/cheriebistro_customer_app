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
    
    // not sure if needed yet
    /// Retrieves the Table information stored in the database for a particular Table and returns it if the Table exists.
    class func loginTable(loginId: String) -> Table? {
        var table: Table?
        let myUrl = URL(string: "http://142.55.32.86:50131/cheriebistro/cheriebistro/api/loginTable.php")!
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = "POST"
        let semaphore = DispatchSemaphore(value: 0)

        let postString = "tableID=\(loginId)"
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
                        let tableId: String = LoginJSON["tableID"] as! String
                        let tableName: String = LoginJSON["tableName"] as! String

                        table = Table(id: tableId, name: tableName)
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
        return table
    }
}
