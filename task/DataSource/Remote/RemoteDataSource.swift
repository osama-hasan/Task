//
//  RemoteDataSource.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//


import Foundation
import Alamofire
import CoreLocation
class RemoteDataSource:RemoteDataSourceProtocol{
    
    
    //MARK: - Properties
    lazy var remoteContext = NetworkManager(baseUrl: "https://api.giphy.com/v1/gifs")
    
    let giphyApiKey = "rz9n0g21eDcWCPyt08cpiST2ElhJVgXI"
    
    func searchGifs(page:Int,pageSize:Int,query: String, completion: @escaping Handler<GiphyResponse>) {
        
        let params : [String : Any] =  ["api_key":giphyApiKey,"q" : query,"offset":page,"limit":pageSize]
        
        remoteContext.request(endpoint: EndPoints.search, method: .get,parameters: params) { result in
            switch result {
            case .success(let data):
                self.dataParamParser(data: data, model: GiphyResponse.self, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func trending(page:Int,pageSize:Int, completion: @escaping Handler<GiphyResponse>) {
        
        let params : [String : Any] =  ["api_key":giphyApiKey,"offset":page,"limit":pageSize,"rating":"g","bundle":"messaging_non_clips"]
        
        remoteContext.request(endpoint: EndPoints.trending, method: .get,parameters: params) { result in
            switch result {
            case .success(let data):
                self.dataParamParser(data: data, model: GiphyResponse.self, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Parsers
    
    private func  dataParamParser<T:Decodable>(data:Data,model:T.Type, completion: @escaping Handler<T>) {
        let decoder =  JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let model = try decoder.decode(T.self, from: data)
            
            completion(.success(model))
            
        } catch {
            completion(.failure(ErrorModel(message: error.localizedDescription)))
        }
    }
    

    
}
