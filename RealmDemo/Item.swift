//
//  Item.swift
//  RealmDemo
//
//  Created by Sumit Ghosh on 10/08/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var body: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var timestamp: Date = Date()
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
    
    
}
