//
//  HomeViewModel.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

class HomeViewModel : NSObject {
    var images : [GiphyGif] = []
    var userFavourites : [Favorite] = []
    
    var isLoadingData = false
    var page = 0
    var pageSize = 20
    var onLoadData : (()->Void)?
    let username = UserDefaultsManager.shared.email
    
    override init() {
        super.init()
        
    }
    
    func getTrending(){
        if isLoadingData {
            return
        }
        isLoadingData = true

        DataSource.shared.trending(page: page, pageSize: pageSize) { [weak self] result in
            guard let self else {return}
            self.isLoadingData = false
            switch result {
            case .success(let response):
                self.images.append(contentsOf: response.data)
                onLoadData?()
                self.page += 1
                self.pageSize += pageSize
            case .failure(let error):
                print(error.message)
            }
        }
    }
    
    func isItemInFavourite(index:Int) -> Bool{
        let item = images[index]
        return userFavourites.contains(where: {$0.favId == item.id })
    }
    
    func toggelFavourite(index:Int){
        let item = images[index]
        if !userFavourites.contains(where: {$0.favId == item.id}) {
            let favorite = Favorite()
            favorite.favId = item.id
            favorite.title = item.title
            favorite.url = item.images.original.url
            userFavourites.append(favorite)
            DataSource.shared.addFavoriteForUser(username: username, id: item.id, title: item.title, url: item.images.original.url)
            return
        }
        userFavourites.removeAll(where: {$0.favId == item.id})

        DataSource.shared.removeFromFavorites(id: item.id, username: username)
    }
    
    

    
    func getUserFavorites(){
        DataSource.shared.getFavoritesForUser(username: username){ [weak self] fav in
            guard let self else {return}
            userFavourites = fav
            self.onLoadData?()
        }
    }
    
    
    
    
    
}
