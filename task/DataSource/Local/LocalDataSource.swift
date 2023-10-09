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
    
    let backgroundQueue = DispatchQueue(label: "com.task", qos: .background, autoreleaseFrequency: .workItem)
    let realm: Realm
    init() {
        let config = Realm.Configuration(schemaVersion:6)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void ) {
        
        backgroundQueue.async {
            let realm = try! Realm(configuration: .defaultConfiguration, queue: self.backgroundQueue)
            if let user = realm.objects(User.self).where({$0.username == username}).first {
                if user.password == password {
                    // Password is correct, login successful
                    DispatchQueue.main.async {
                        completion(true)
                        
                    }
                    
                } else {
                    // Password is incorrect
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    
                }
            } else {
                // User does not exist, create a new user
                let newUser = User()
                newUser.username = username
                newUser.password = password
                
                realm.writeAsync {
                    realm.add(newUser)
                }
                
                // User created and logged in
                DispatchQueue.main.async {
                    completion(true)
                }
            }
            
        }
    }
    
    
    
    func observeFavorites(forUser username: String, completion: @escaping ([Favorite]) -> Void) {

        if let user = realm.objects(User.self).where({$0.username == username}).first {
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
        
        
        // Query for the favorites with a limit and offset
        let favorites = realm.objects(Favorite.self)
            .where({$0.user.username == username})
        
        
        completion(Array(favorites))
    }
    
    
    func addFavoriteForUser(username: String,id:String ,title: String, url: String,originalUrl:String) {
        
        if let user = realm.objects(User.self).where({$0.username == username}).first {
            // Create a new Favorite object
            let favorite = Favorite()
            favorite.title = title
            favorite.url = url
            favorite.favId = id
            favorite.originalUrl = originalUrl
            // Add the favorite to the user's favorites
            //        do {
            realm.writeAsync {
                
                user.favorites.append(favorite)
            }
        }
    }
    
    
    func removeFromFavorites(id: String, username: String) {
        
        if let user = realm.objects(User.self).where({$0.username == username}).first {
            if let favoriteToRemove = user.favorites.first(where: { $0.favId == id }) {
                // Remove the favorite from the user's favorites
                realm.writeAsync {
                    self.realm.delete(favoriteToRemove)
                }
            }
        }
    }
    
}
