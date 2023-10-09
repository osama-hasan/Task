//
//  User.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var username: String = ""
    @Persisted var password: String = ""
    
    @Persisted var favorites = List<Favorite>()
    
    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }
}
