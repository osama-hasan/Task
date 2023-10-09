//
//  UIImageViewExtension.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setKFTemplateImage(with resource: Resource?, placeholder: Placeholder? = nil)  {
        self.kf.setImage(with: resource,placeholder: placeholder, completionHandler:  { [weak self] result in
            switch result {
            case .success(let model):
                self?.image = model.image.withRenderingMode(.alwaysTemplate)
            case .failure(_):
                break
            }
        })
    }
    
    func setKFImage(with resource: Resource?, placeholder: Placeholder? = UIImage(named: "image_place_holder"))  {
        self.kf.setImage(with: resource,placeholder: placeholder,options: [.processor(DownsamplingImageProcessor(size: CGSize(width: self.frame.size.width * UIScreen.main.scale, height: self.frame.size.height * UIScreen.main.scale)))])
    }
}
