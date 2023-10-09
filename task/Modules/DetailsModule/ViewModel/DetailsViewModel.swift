//
//  DetailsViewModel.swift
//  task
//
//  Created by Osama Hasan on 09/10/2023.
//

import Foundation

class DetailsViewModel : NSObject {
    
    var selectedId: String!
    var isFavorite = false
    let username = UserDefaultsManager.shared.email
    var selectedGif: GiphyGif?
    var onLoadData : (()->Void)?

    let dataUpdatedNotification = Notification.Name("DataUpdatedNotification")

    func getById(){
        Loader.show()
        DataSource.shared.getById(id: selectedId) { [weak self] result in
            Loader.hide()
            guard let self else {return}
            switch result {
            case .success(let response):
                self.selectedGif = response.data
                self.onLoadData?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func toggelFavourite(){
        defer {
            isFavorite.toggle()
            onLoadData?()
            let userInfo : [String:String] = ["id": selectedId]
            NotificationCenter.default.post(name: dataUpdatedNotification, object: self, userInfo: userInfo)
        }
        guard let selected = selectedGif else {return}
        if !isFavorite {
            let favorite = Favorite()
            favorite.favId = selected.id
            favorite.title = selected.title
            favorite.url = selected.images.fixedWidthDownsampled.url
            favorite.originalUrl = selected.images.original.url
            DataSource.shared.addFavoriteForUser(username: username, id: favorite.favId, title: favorite.title, url: favorite.url, originalUrl: favorite.originalUrl)

            return
        }
        DataSource.shared.removeFromFavorites(id: selected.id, username: username)

    }
}
