//
//  GiphyCell.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit

class GiphyCell: UICollectionViewCell {
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var isFavorite = false
    
    var onSelectFavourite: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favouriteButton.layer.cornerRadius = favouriteButton.frame.width / 2
    
        
    }
    
    
    func setData(data:GiphyGif,isFavorite:Bool){
        imageTitleLabel.text = data.title
        if let url = URL(string: data.images.original.url){
            imageView.setKFImage(with: url)
        }
        
        self.isFavorite = isFavorite
        setFavoriteUI()
    }
    
    func setData(data:Favorite){
        isFavorite = true
        imageTitleLabel.text = data.title
        if let url = URL(string: data.url){
            imageView.setKFImage(with: url)
        }
        setFavoriteUI()
    }
    @IBAction func favouriteTap(_ sender: Any) {
        isFavorite.toggle()
        setFavoriteUI()
        onSelectFavourite?()
    }
    
    
    func setFavoriteUI(){
        if !isFavorite {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteButton.tintColor = .white
            return
        }
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favouriteButton.tintColor = .red
    }
}
