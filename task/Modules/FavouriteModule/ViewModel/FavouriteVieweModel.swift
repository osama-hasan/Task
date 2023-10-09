//
//  FavouriteVieweModel.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

class FavouriteVieweModel : NSObject {
    var userFavourites : [Favorite] = []
    let username = UserDefaultsManager.shared.email

    
    
    var onLoadData : (()->Void)?

   
    
    func removeFromFavorites(index:Int){


        let item = userFavourites[index]
        DataSource.shared.removeFromFavorites(id: item.favId, username: username)
    }
    
    func observeOnUserFaorite(){
        DataSource.shared.observeFavorites(forUser: username) { [weak self] fav in
            guard let self else {return}
            userFavourites = fav
            self.onLoadData?()
        }
    }
}
