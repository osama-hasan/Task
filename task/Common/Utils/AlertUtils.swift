//
//  AlertUtils.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//


import UIKit

func showErrorMessage(_ title:String, message:String, okLabel:String,handler:(()->Void)? = nil) -> Void {
    
    DispatchQueue.main.async {
        
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okLabel, style: .default, handler: {_ in handler?()})
        
        alert.addAction(okAction)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            if let topViewController = window.topMostViewController {
                // Now, you can work with the topmost view controller
                // For example, you can present a new view controller from it:
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}


func showErrorMessage( _ message:String? = nil ) -> Void {
    DispatchQueue.main.async {
    showErrorMessage("",
                     message: message ?? "",
                     okLabel: "Ok")
    }
}
