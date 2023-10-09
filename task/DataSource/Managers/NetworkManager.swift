//
//  NetworkManager.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

import Alamofire

class NetworkManager {

    // Define your API base URL
    let baseURL:String
    
    init(baseUrl:String) {
        self.baseURL = baseUrl
    }


    func request(endpoint: EndPoints, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping Handler<Data>) {
        let url = baseURL + endpoint.getEndPoint()

        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data else {
                        completion(.failure(ErrorModel(message: "General Error")))
                        return
                    }
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(ErrorModel(message: error.localizedDescription)))
                }
            }
    }
}




class ErrorModel : Error {
    let message :String
    
    init(message:String){
        self.message = message
    }
}
