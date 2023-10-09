//
//  Favorite.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted var favId: String = ""
    @Persisted var title: String = ""
    @Persisted var url: String = ""
    
    
    @Persisted var user = LinkingObjects(fromType: User.self, property: "favorites")

    
}
