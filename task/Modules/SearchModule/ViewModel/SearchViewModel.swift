//
//  SearchViewModel.swift
//  task
//
//  Created by Osama Hasan on 09/10/2023.
//

import Foundation

class SearchViewModel : NSObject {
    
    var searchResult: [GiphyGif] = []
    var userFavourites : [Favorite] = []
    let username = UserDefaultsManager.shared.email
    
    var searchQuery = ""
    var page = 0
    var pageSize = 20
    var searchTimer: Timer?
    
    
    var onLoadData : (()->Void)?
    
    
    func isItemInFavourite(index:Int) -> Bool{
        let item = searchResult[index]
        return userFavourites.contains(where: {$0.favId == item.id })
    }
    
    func toggelFavourite(index:Int){
        let item = searchResult[index]
        if !userFavourites.contains(where: {$0.favId == item.id}) {
            let favorite = Favorite()
            favorite.favId = item.id
            favorite.title = item.title
            favorite.url = item.images.fixedWidthDownsampled.url
            favorite.originalUrl = item.images.original.url
            userFavourites.append(favorite)
            DataSource.shared.addFavoriteForUser(username: username, id: favorite.favId, title: favorite.title, url: favorite.url, originalUrl: favorite.originalUrl)
            return
        }
        userFavourites.removeAll(where: {$0.favId == item.id})
        
        DataSource.shared.removeFromFavorites(id: item.id, username: username)
    }
    
    func setQueryText(text:String){
        self.searchQuery = text
        
        // Invalidate the previous timer (if any)
        searchTimer?.invalidate()
        
        // Create a new timer that fires after 1 second
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] timer in
            // Perform the search or desired action here
            self?.getSearch()
        }
        
    }
    func getSearch(){
        DataSource.shared.searchGifs(page: page, pageSize: 20, query: searchQuery) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let response):
                searchResult = response.data
                onLoadData?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
