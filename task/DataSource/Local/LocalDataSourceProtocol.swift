//
//  LocalDataSourceProtocol.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation


protocol LocalDataSourceProtocol {
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) 
   
    func getFavoritesForUser(username: String, completion: @escaping ([Favorite]) -> Void)
    
    func addFavoriteForUser(username: String, id:String,title: String, url: String,originalUrl:String)
    
    func removeFromFavorites(id: String, username: String)
    func observeFavorites(forUser username: String, completion: @escaping ([Favorite]) -> Void)
}
