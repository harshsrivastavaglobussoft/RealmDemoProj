//
//  Project.swift
//  RealmDemo
//
//  Created by Sumit Ghosh on 10/08/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import RealmSwift

class Project: Object {
    @objc dynamic var projectId:String = UUID().uuidString
    @objc dynamic var owner: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var timestamp: Date = Date()
    
    let items = List<Item>()
    let permissions = List<Permission>()
    
    override static func primaryKey() -> String? {
        return "projectId"
    }
}
