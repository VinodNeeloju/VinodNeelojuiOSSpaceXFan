//
//  String+Extension.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import Foundation
import UIKit

extension String {
    /// Get the height of the given string by using the width and font boundingRect
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Get the width of the given string by using the height and font boundingRect
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    ///This property is to validate the email is valid email or not .
    ///This propery just checks the email format/criteria, It wont hit any server to validate the email is real or fake.
    public var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
     
}

extension NSMutableAttributedString {
   
    ///This method is to make the changes in font of the perticiular characters.
    @discardableResult func font(name : String, size : Int) -> NSMutableAttributedString {
        let range = (self.string as NSString).range(of: self.string)
        self.addAttribute(.font, value: UIFont(name: name, size: CGFloat(size))!, range: range)
        return self
    }
    
    ///This method is to change the color or the entire string
    @discardableResult func changeTextColor(to color : UIColor) -> NSMutableAttributedString {
        let range = (self.string as NSString).range(of: self.string)
        self.addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
    ///This method is to change the color or the perticular string
    @discardableResult func changeTextColor(of string : String, to color : UIColor) -> NSMutableAttributedString {
        let range = (self.string as NSString).range(of: string)
        self.addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
    ///This method is to make the given string bold
    @discardableResult func bold(_ text: String, _ size : Int) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: CGFloat(size))]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    ///This method is to make the given string bold and font size and text color
    @discardableResult func bold(_ text: String, _ size : Int, _ textColor : UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font:  UIFont.boldSystemFont(ofSize: CGFloat(size)), .foregroundColor : textColor]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    ///This method is to make the given string normal and font size
    @discardableResult func normal(_ text: String, _ size : Int) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        return self
    }
    
    ///This method is to make the given string normal and font size and text color
    @discardableResult func normal(_ text: String, _ size : Int, _ textColor : UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font:  UIFont.systemFont(ofSize: CGFloat(size)), .foregroundColor : textColor]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        return self
    }
        
}
