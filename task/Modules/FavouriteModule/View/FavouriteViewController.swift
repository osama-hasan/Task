//
//  FavouriteViewController.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var favourtieCollectionView: UICollectionView!
    let viewModel = FavouriteVieweModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        
        setupViews()
        viewModel.observeOnUserFaorite()
    }


    func setupViews(){
        favourtieCollectionView.dataSource = self
        favourtieCollectionView.delegate = self
        viemModelLiseners()
    }
    
    func registerCells(){
        favourtieCollectionView.register(cellClass: GiphyCell.self)
    }
    
    
    func viemModelLiseners(){
        viewModel.onLoadData = { [weak self] in
            self?.favourtieCollectionView.reloadData()
        }
    }

}

extension FavouriteViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userFavourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GiphyCell.self, for: indexPath)
        let cellData = viewModel.userFavourites[indexPath.row]

        cell.setData(data: cellData)
        cell.onSelectFavourite = { [weak self] in
            guard let self else {return}
            self.viewModel.removeFromFavorites(index: indexPath.row)
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
    
}
