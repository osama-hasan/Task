//
//  SearchViewController.swift
//  task
//
//  Created by Osama Hasan on 09/10/2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCells()
        viewModelListeners()
    }


    
    func registerCells(){
        searchResultCollectionView.register(cellClass: GiphyCell.self)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    
    func viewModelListeners(){
        viewModel.onLoadData = { [weak self] in
            DispatchQueue.main.async{
                self?.searchResultCollectionView.reloadData()
            }
        }
    }

}


extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GiphyCell.self, for: indexPath)
        let cellData = viewModel.searchResult[indexPath.row]

        let isFavorite = viewModel.isItemInFavourite(index: indexPath.row)
        cell.setData(data: cellData,isFavorite: isFavorite)
        cell.onSelectFavourite = { [weak self] in
            guard let self else {return}
            self.viewModel.toggelFavourite(index: indexPath.row)
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
        let item = viewModel.searchResult[indexPath.row]
        
        let viewController = Router.ViewController(vc: DetailsViewController.self)
        viewController.viewModel.selectedId = item.id
        viewController.viewModel.isFavorite = true
        self.present(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
