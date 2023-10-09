//
//  LocalDataSource.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//


import Foundation
import RealmSwift

class LocalDataSource:LocalDataSourceProtocol {
    
    
    private var notificationToken: NotificationToken?
    
    let backgroundQueue = DispatchQueue(label: "com.task", qos: .background)
    let realm: Realm
    init() {
        let config = Realm.Configuration(schemaVersion:5)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void ) {
        
        
        
        
        if let user = realm.objects(User.self).filter("username == %@", username).first {
            if user.password == password {
                // Password is correct, login successful
                completion(true)
                
            } else {
                // Password is incorrect
                completion(false)
                
            }
        } else {
            // User does not exist, create a new user
            let newUser = User()
            newUser.username = username
            newUser.password = password
            
            try! realm.write {
                self.realm.add(newUser)
            }
            
            // User created and logged in
            completion(true)
        }
    
    
}



func observeFavorites(forUser username: String, completion: @escaping ([Favorite]) -> Void) {
    
    
    if let user = realm.objects(User.self).filter("username == %@", username).first {
        self.notificationToken = user.favorites.observe {  (changes) in
            switch changes {
            case .initial(let favorites):
                completion(Array(favorites))
                break
            case .update(let favorites, _, _, _):
                
                completion(Array(favorites))
                
            case .error(let error):
                print("Error observing Realm changes: \(error.localizedDescription)")
            }
        }
    }
}

func getFavoritesForUser(username: String, completion: @escaping ([Favorite]) -> Void) {
    
    
    if let user = realm.objects(User.self).filter("username == %@", username).first {
        // Use backgroundRealm to access Realm objects
        let favorites = Array(user.favorites)
        DispatchQueue.main.async {
            // Return the results on the main thread
            completion(favorites)
        }
    } else {
        DispatchQueue.main.async {
            // Return an empty array on the main thread
            completion([])
        }
    }
}


func addFavoriteForUser(username: String,id:String ,title: String, url: String) {
    
    if let user = realm.objects(User.self).filter("username == %@", username).first {
        // Create a new Favorite object
        let favorite = Favorite()
        favorite.title = title
        favorite.url = url
        favorite.favId = id
        // Add the favorite to the user's favorites
        do {
            try realm.write {
                
                user.favorites.append(favorite)
            }
        } catch {
            // Handle any errors here
            print("Error: \(error.localizedDescription)")
        }
        
    }
}


func removeFromFavorites(id: String, username: String) {
    if let user = realm.objects(User.self).filter("username == %@", username).first {
        if let favoriteToRemove = user.favorites.first(where: { $0.favId == id }) {
            // Remove the favorite from the user's favorites
            try! realm.write {
                realm.delete(favoriteToRemove)
            }
        }
    }
}

}
