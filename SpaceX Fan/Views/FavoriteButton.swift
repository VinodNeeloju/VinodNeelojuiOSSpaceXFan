//
//  FavoriteButton.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 28/06/21.
//

import UIKit

class FavoriteButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private let unfavoriteScale: CGFloat = 0.7
    private let favoriteScale: CGFloat = 1.3
    private let unfavoriteImage = #imageLiteral(resourceName: "unbookmark").withRenderingMode(.alwaysTemplate)
    private let favoriteImage = #imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysTemplate)
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setImage(unfavoriteImage, for: .normal)
        self.setImage(favoriteImage, for: .selected)
    }
    
    ///Overriding the isSelected property to make some cool animation..
    func setSelected(flag : Bool) {
        isSelected = !isSelected
        UIView.animate(withDuration: 0.1, animations: {
            let newScale = self.isSelected ? self.favoriteScale : self.unfavoriteScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
//    override var isSelected: Bool {
//        didSet {
//            UIView.animate(withDuration: 0.1, animations: {
//                let newScale = self.isSelected ? self.favoriteScale : self.unfavoriteScale
//                self.transform = self.transform.scaledBy(x: newScale, y: newScale)
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.1, animations: {
//                    self.transform = CGAffineTransform.identity
//                })
//            })
//        }
//    }
}

