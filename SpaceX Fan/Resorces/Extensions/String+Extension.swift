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
    
    ///Password validation this method will check whether user entered 6 digits or not and and atleast a char and number should be present in the password.
    ///The return type is Bool. If the provided string satisfies the conditions this will return true or else false
    public var isValidPassword: Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
}
