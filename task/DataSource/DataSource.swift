//
//  DataSource.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

final class DataSource: DataSourceProtocol{
    
   
    //MARK: - Initializers
    private init() {
    }
  
    //MARK: Shared Instance
    static var shared: DataSourceProtocol = DataSource()
    
    
   
    
    //MARK: - Properties
    lazy var remoteDataSource:RemoteDataSourceProtocol = RemoteDataSource()
    lazy var localDataSource:LocalDataSourceProtocol = LocalDataSource()
    

    
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void){
        localDataSource.login(username: username, password: password,completion: completion)
    }
    
    func getFavoritesForUser(username: String, completion: @escaping ([Favorite]) -> Void) {
        localDataSource.getFavoritesForUser(username: username,completion: completion)
    }
    
    func addFavoriteForUser(username: String, id: String, title: String, url: String, originalUrl: String) {
        localDataSource.addFavoriteForUser(username: username, id: id, title: title, url: url,originalUrl: originalUrl)
    }
    
    func removeFromFavorites(id: String, username: String) {
        localDataSource.removeFromFavorites(id: id, username: username)
    }
  
    
    
    func searchGifs(page:Int,pageSize:Int,query: String, completion: @escaping Handler<GiphyResponse>) {
        remoteDataSource.searchGifs(page: page, pageSize: pageSize,query: query, completion: completion)
    }
    
    func trending(page:Int,pageSize:Int, completion: @escaping Handler<GiphyResponse>) {
        remoteDataSource.trending(page: page, pageSize: pageSize, completion: completion)
    }
    func observeFavorites(forUser username: String, completion: @escaping ([Favorite]) -> Void){
        localDataSource.observeFavorites(forUser: username, completion: completion)
    }
    
    func getById(id: String, completion: @escaping Handler<GiphySingleResponse>) {
        remoteDataSource.getById(id: id, completion: completion)
    }
    
}
