//
//  TabBarController.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit
import Alamofire
import AVFoundation

enum Tab:Int,CaseIterable {
    case home = 0
    case favourite = 1

    
    var viewController:UIViewController{
        switch self {
        case .home:
            return Router.ViewController(vc: HomeViewController.self)
        case .favourite:
            return Router.ViewController(vc: FavouriteViewController.self)

        }
    }
    
    var imageName:(img:String, selectedImg:String){
        switch self {
        case .home:
           return ("house.fill","house.fill")
        case .favourite:
            return("heart.fill","heart.fill")
       
        }
    }
    
    var tabTitle:String {
        switch self {
        case .home:
           return "Home"
        case .favourite:
            return "Favourite"

      
        }
    }
    var vcTitle:String {
        switch self {
        case .home:
           return "Home"
        case .favourite:
            return "Favourite"
        }
    }

}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var navControllers:[UINavigationController]?
    var rootVCs:[UIViewController]? = []
 //   var  noInternetBannerView:UIView?
   // let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.tabBar.unselectedItemTintColor = .grey500
        self.tabBar.tintColor = .primaryColor
        self.tabBar.backgroundColor = .white
        self.delegate =  self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always

        self.navigationController?.isNavigationBarHidden = false
        if navControllers == nil {
            navControllers = Tab.allCases.map { (tap) -> UINavigationController in
                let vc = tap.viewController
                vc.title = tap.vcTitle
                vc.view.backgroundColor =  .white
                vc.navigationController?.navigationBar.prefersLargeTitles = true
                vc.navigationController?.navigationItem.largeTitleDisplayMode = .always    
              
                
                vc.tabBarItem  = UITabBarItem(title: tap.tabTitle, image:  UIImage(systemName: tap.imageName.img),selectedImage: UIImage(systemName:  tap.imageName.selectedImg))
                
                let inset:CGFloat = 0
                vc.tabBarItem.imageInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
                rootVCs?.append(vc)
                return UINavigationController(rootViewController: vc)
            }
            setViewControllers(navControllers, animated: false)
            self.navigationController?.navigationBar.prefersLargeTitles = true
            selectedIndex = 0
        }
         
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
      self.navigationController?.isNavigationBarHidden = true

    }
    

}
