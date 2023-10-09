//
//  FavouriteViewController.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var favourtieCollectionView: UICollectionView!
    let viewModel = FavouriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        
        setupViews()
        
      
    }


    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    func setupViews(){
        favourtieCollectionView.dataSource = self
        favourtieCollectionView.delegate = self
        viewModelListeners()
    }
    
    func registerCells(){
        favourtieCollectionView.register(cellClass: GiphyCell.self)
    }
    
    
    
    func viewModelListeners(){
        viewModel.observeOnUserFaorite()
        
        viewModel.onLoadData = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async{
                self.favourtieCollectionView.reloadData()
                self.tabBarItem.badgeValue = "\(self.viewModel.userFavourites.count)"
            }
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
        
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        
        if isIpad {
            let width = collectionView.frame.width / 4 - 8
            let hight =  collectionView.frame.width / 4 - 8
            return CGSize(width: width, height: hight)
        } else {
            // For iPhone, 2 columns
            let width = collectionView.frame.width / 2 - 8
            let hight =  collectionView.frame.width / 2 - 8
            return CGSize(width: width, height: hight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.userFavourites[indexPath.row]
        
        let viewController = Router.ViewController(vc: DetailsViewController.self)
        viewController.viewModel.selectedId = item.favId
        viewController.viewModel.isFavorite = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
