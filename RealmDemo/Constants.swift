//
//  Constants.swift
//  RealmDemo
//
//  Created by Sumit Ghosh on 10/08/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation

struct Constants {
    
    static let MY_INSTANCE_ADDRESS = "noteapp.us1.cloud.realm.io"
    static let AUTH_URL = URL.init(string: "https://\(MY_INSTANCE_ADDRESS)")!
    static let REALM_URL = URL.init(string: "realms://\(MY_INSTANCE_ADDRESS)/ToDo")!
}
