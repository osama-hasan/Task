//
//  FavouriteVieweModel.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

class FavouriteViewModel : NSObject {
    var userFavourites : [Favorite] = []
    let username = UserDefaultsManager.shared.email
    
    var favoriteCount: Int = 0
    
    var onLoadData : (()->Void)?
    
    let dataUpdatedNotification = Notification.Name("DataUpdatedNotification")
    
    
    func removeFromFavorites(index:Int){
        let item = userFavourites[index]
        DataSource.shared.removeFromFavorites(id: item.favId, username: username)
        
        let userInfo = ["id": item.favId]
        // Post a notification with the userInfo dictionary
        NotificationCenter.default.post(name: dataUpdatedNotification, object: self, userInfo: userInfo)
    }
    
    func observeOnUserFaorite(){
        DataSource.shared.observeFavorites(forUser: username) { [weak self] fav in
            guard let self else {return}
            userFavourites = fav
            self.onLoadData?()
        }
    }
}
