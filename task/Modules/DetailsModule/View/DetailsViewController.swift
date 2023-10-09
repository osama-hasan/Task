//
//  DetailsViewController.swift
//  task
//
//  Created by Osama Hasan on 09/10/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        
        viewModelListeners()
    }
    
    
    func setupUI(){
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        gifImageView.layer.cornerRadius = 12
    }
    
    
    func setFavoriteUI(){
        if !viewModel.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
            return
        }
        
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .red
    }
    
    
    func viewModelListeners(){
        viewModel.getById()
        
        viewModel.onLoadData = { [weak self] in
            guard let self, let selected = viewModel.selectedGif ,let url = URL(string: selected.images.original.url) else {return}
            self.gifImageView.setKFImage(with: url)
            self.titleLabel.text = selected.title
            self.setFavoriteUI()
            self.slugLabel.text = selected.slug
        }
    }
    
    @IBAction func favoriteTap(_ sender: Any) {
        viewModel.toggelFavourite()
    }
    
}
