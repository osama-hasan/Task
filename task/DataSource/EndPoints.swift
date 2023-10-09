//
//  EndPoints.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

enum EndPoints{
    case search
    case trending
    case getById(id:String)
}

extension EndPoints {
    func getEndPoint()->String{
        switch self {
            
        case .search:
            return "/search"
        case .trending:
            return "/trending"
        case .getById(id: let id):
            return "/\(id)"
        }
    }
}
