//
//  AppDelegate.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit
import Kingfisher
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    var window: UIWindow?
    
    static var shared: AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024 // 100 MB

        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaultsManager.shared.email.isEmpty {
            Router.showLogin(for: window!)
        }else{
            Router.setTabBar(for: window!)
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

