//
//  RemoteDataSourceProtocol.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

protocol RemoteDataSourceProtocol {
    
    func searchGifs(page:Int,pageSize:Int,query: String, completion: @escaping Handler<GiphyResponse>)
    func trending(page:Int,pageSize:Int, completion: @escaping Handler<GiphyResponse>)
    func getById(id:String, completion: @escaping Handler<GiphySingleResponse>)
}
