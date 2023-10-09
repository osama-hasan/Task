//
//  Loader.swift
//  task
//
//  Created by Osama Walid on 09/10/2023.
//


import UIKit

class Loader: UIView {
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    static var view:Loader?
    private static let animationDuration:Double = 0.2
    
    
    override func awakeFromNib() {}
    
    class func show(inViewController vc:UIViewController? = nil,completionHandler:(() -> Void)? = nil){
        if view == nil {
            view = Bundle.main.loadNibNamed("Loader", owner: self)?.first as? Loader
        }
        view!.frame = UIScreen.main.bounds
        view!.layoutIfNeeded()
        view!.setNeedsDisplay()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            if let vcToShowLoader = window.topMostViewController {
                // Now, you can work with the topmost view controller
                // For example, you can present a new view controller from it:
                if let navigationView =  vcToShowLoader.navigationController?.view {
                    navigationView.addSubview(view!)
                }else{
                    vcToShowLoader.view.addSubview(view!)
                }
                
                
                view!.activityIndicator.startAnimating()
                view!.alpha = 0
                UIView.animate(withDuration: animationDuration) {
                    view!.alpha = 1
                }
            }
        }
        
    }
    
    
    class func hide()  {
        UIView.animate(withDuration: animationDuration) {
            view!.alpha = 0
        } completion: { _ in
            Loader.view?.activityIndicator.stopAnimating()
            Loader.view?.removeFromSuperview()
        }
    }
    
}
