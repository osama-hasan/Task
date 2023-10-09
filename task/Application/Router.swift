//
//  Router.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import UIKit


class Router {
    
    static var tab:TabBarController!

    class func ViewController<T:UIViewController>(vc:T.Type) ->T{
        let vc = T(nibName: NSStringFromClass(vc.classForCoder()).components(separatedBy: ".").last ?? "", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    class func NavigationController<T:UIViewController>(vc:T.Type,data:Any? = nil) ->UINavigationController{
        let vc = T(nibName: NSStringFromClass(vc.classForCoder()).components(separatedBy: ".").last ?? "", bundle: nil)
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        return nav
    }
    
    
    static func showLogin(for window:UIWindow){
        let  login = Router.NavigationController(vc: LoginViewController.self)
        
        window.rootViewController = login
        window.makeKeyAndVisible()
        AppDelegate.shared.window = window
    }
    
    
    static func setTabBar(for window: UIWindow){
        tab =  TabBarController()
        window.rootViewController = tab
        window.makeKeyAndVisible()
        AppDelegate.shared.window = window
    }
    
}
