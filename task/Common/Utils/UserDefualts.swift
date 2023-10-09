//
//  UserDefualts.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import Foundation

class UserDefaultsManager{
    
    private enum Keys : String {
        case isLoggedIn = "isLoggedIn"
        case email = "email"
    
    }

    static var shared = UserDefaultsManager()
    
    private init(){}
    
    var email:String {
        get {
            return UserDefaults.standard.object(forKey: Keys.email.rawValue) as? String ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.email.rawValue)
        }
    }
   
}
