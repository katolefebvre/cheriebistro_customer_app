//
//  TimeSlot.swift
//  GlacoOrderApp
//
//  Created by Kato Lefebvre on 2020-09-23
//  Copyright © 2020 GLAC Co. All rights reserved.
//

import UIKit

class TimeSlot: NSObject {
    
    /// The ID of the TimeSlot.
    var id: Int?
    
    /// The Name of the TimeSlot.
    var name: String?
    
    override init() {}
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
