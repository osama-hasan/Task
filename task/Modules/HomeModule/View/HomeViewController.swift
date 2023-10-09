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
    
    lazy var searchViewController = SearchViewController()
    
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
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        viewModelListeners()
        configureSearchBar()
    }
    
    func registerCells(){
        imagesCollectionView.register(cellClass: GiphyCell.self)
    }
    
    
    func configureSearchBar()  {
        
        
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .grey300
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
    }
    func viewModelListeners(){
        viewModel.getTrending()
        viewModel.getUserFavorites()
        viewModel.onLoadData = { [weak self] in
            DispatchQueue.main.async{
                self?.imagesCollectionView.reloadData()
            }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.images[indexPath.row]
        
        let viewController = Router.ViewController(vc: DetailsViewController.self)
        viewController.viewModel.selectedId = item.id
        viewController.viewModel.isFavorite = viewModel.isItemInFavourite(index: indexPath.row)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.imagesCollectionView.contentOffset.y >= (self.imagesCollectionView.contentSize.height - self.imagesCollectionView.bounds.size.height)) {
            
            viewModel.getTrending()
        }
    }
    
    
    
}


extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let vc = searchController.searchResultsController as? SearchViewController {
            if let text = searchController.searchBar.text {
                vc.viewModel.setQueryText(text: text)
            }
        }
    }
    
}
