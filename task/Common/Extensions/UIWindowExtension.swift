//
//  UIWindowExtension.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import UIKit

extension UIWindow {
    var topMostViewController: UIViewController? {
        return self.topViewController
    }
    
    var topViewController: UIViewController? {
        guard let rootViewController = self.rootViewController else {
            return nil
        }
        
        return topViewControllerWithRootViewController(rootViewController)
    }
    
    private func topViewControllerWithRootViewController(_ rootViewController: UIViewController) -> UIViewController {
        if let presentedViewController = rootViewController.presentedViewController {
            return topViewControllerWithRootViewController(presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController,
           let topViewController = navigationController.topViewController {
            return topViewControllerWithRootViewController(topViewController)
        }
        
        if let tabBarController = rootViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return topViewControllerWithRootViewController(selectedViewController)
        }
        
        return rootViewController
    }
}
