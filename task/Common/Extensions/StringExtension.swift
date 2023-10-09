//
//  StringExtension.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation
import UIKit

extension Optional where Wrapped == String {
    
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidName: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[\\p{L}\\p{M} ]+$").evaluate(with: self)
    }
    
    func verifyUrl () -> Bool {
        if let self = self {
            if let url = NSURL(string: self) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    var isPasswordValid : Bool  {
        
        return NSPredicate(format: "SELF MATCHES %@","^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$").evaluate(with: self?.trimmingCharacters(in: CharacterSet.whitespaces))
        
    }
    
    var isValidPhone: Bool {
        let phoneNumberRegex = "^(?!0)[0-9]{9,15}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: self)
    }
    
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isWhiteSpace
        }
        return true
        
    }
    
    
    
}

extension String {
    var isWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    func isPrefixOfWord(_ prefix:String, separtor:Character = ",") -> Bool {
        let words = self.split(separator: separtor)
        for word in words {
            if word.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
    
    func width(forFont font:UIFont) -> CGFloat {
        let font = font
        let fontAttributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: fontAttributes).width
    }
    
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isPasswordValid : Bool  {
        
        return self.count >= 8
        
    }
}


extension String {
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
}

extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
}
