//
//  UIView+Extension.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import Foundation
import UIKit

extension UIView {
    
    /// To show the toast message on top of the view.
    /// Used UILabel to display toast message and it will disapear within 3 secs with animation. Used UIView animation
    
    /**Display the toast on top of the screen*/
    public func makeToast(_ string : String?) {
        DispatchQueue.main.async {
            guard let string = string else { return }
            let tag = 9705897082
            let font = UIFont.systemFont(ofSize: 14)
            
            let x : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 100.0 : 30.0
            let y : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 100.0 : 50.0
            let width = UIDevice.current.userInterfaceIdiom == .pad ? Constants.Bounds.width - 200.0 : Constants.Bounds.width - 60.0
            let height = string.height(withConstrainedWidth: width , font: font) + 30.0
            
            guard Constants.KeyWindow?.viewWithTag(tag) == nil else { return }
            
            let messageLabel : UILabel = {
                let label = UILabel()
                label.text = string
                label.tag = tag
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.textAlignment = .center
                label.font = font
                label.backgroundColor = Constants.Colors.Red
                label.textColor = .white
                label.layer.cornerRadius = 10
                label.layer.masksToBounds = true
                return label
            }()
            
            messageLabel.frame = CGRect(x: x, y: -10, width: width, height: height)
            Constants.KeyWindow?.addSubview(messageLabel)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
                //Do all animations here
                Constants.KeyWindow?.viewWithTag(tag)?.frame = CGRect(x: x, y: y, width: width, height: height)
            }, completion: {
                //Code to run after animating
                (value: Bool) in
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
                    //Do all animations here
                    Constants.KeyWindow?.viewWithTag(tag)?.frame = CGRect(x: x, y: -60, width: width, height: height)
                }, completion: {
                    //Code to run after animating
                    (value: Bool) in
                    Constants.KeyWindow?.viewWithTag(tag)?.removeFromSuperview()
                })
            }
        }
    }
    
}


extension UIView {
    
    ///This property set and get the borderWidth of the view layer
    ///Using IBInspectable helps to develop create a best UI and shortcut in Storyboard/XIB
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    ///This property set and get the borderColor of the view layer
    ///Using IBInspectable helps to develop create a best UI and shortcut in Storyboard/XIB
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    ///This property set and get the cornerRadius of the view layer
    ///Using IBInspectable helps to develop create a best UI and shortcut in Storyboard/XIB
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    ///This method will share the uiview and returns to the same position after 0.1 sec
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 20, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 20, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    
    func addGradient(_ size : CGSize, _ colors : [CGColor] = [
        UIColor(red:0.25, green:0.37, blue:0.54, alpha:1).cgColor,
        UIColor(red:0.12, green:0.19, blue:0.32, alpha:0).cgColor
    ])
    {
        
        let layer_ = self.viewWithTag(6565)
        if layer_ != nil {
            layer_?.removeFromSuperview()
        }
        
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        layer.layer.cornerRadius = self.layer.cornerRadius
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: layer.frame.width, height: layer.frame.height)
        gradient.colors = colors
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.name = "GradLay"
        layer.tag = 6565
        layer.layer.addSublayer(gradient)
        
        self.addSubview(layer)
        
    }
    
    
}
