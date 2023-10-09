//
//  HomeViewController.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        
        viewModel.getTrending()
        viewModel.getUserFavorites()

        setupViews()

    }

    func setupViews(){
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        viemModelLiseners()
    }
    
    func registerCells(){
        imagesCollectionView.register(cellClass: GiphyCell.self)
    }
    
    
    func viemModelLiseners(){
        viewModel.onLoadData = { [weak self] in
            self?.imagesCollectionView.reloadData()
        }
    }

}


extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GiphyCell.self, for: indexPath)
        let cellData = viewModel.images[indexPath.row]
        let isFavorite = viewModel.isItemInFavourite(index: indexPath.row)

        cell.setData(data: cellData,isFavorite: isFavorite)
        cell.onSelectFavourite = { [weak self] in
            guard let self else {return}
            self.viewModel.toggelFavourite(index: indexPath.row)
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        let width = collectionView.frame.width / 2 - 8
        let hight =  collectionView.frame.width / 2 - 8
        
        return CGSize(width: width, height: hight)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.imagesCollectionView.contentOffset.y >= (self.imagesCollectionView.contentSize.height - self.imagesCollectionView.bounds.size.height)) {

            viewModel.getTrending()
        }
    }
    
}

