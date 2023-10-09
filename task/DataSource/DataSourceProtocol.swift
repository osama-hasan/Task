//
//  DataSourceProtocol.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

typealias Handler<T> = (Result<T, ErrorModel>) -> Void

protocol DataSourceProtocol:RemoteDataSourceProtocol,LocalDataSourceProtocol {
}
