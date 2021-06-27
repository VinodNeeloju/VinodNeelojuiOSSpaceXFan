//
//  PreviewImageCollectionViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class PreviewImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageview: UIImageView!
    
    public var imageString : String? {
        didSet {
            self.setImage()
        }
    }
    
    private func setImage() {
        DispatchQueue.main.async {
            guard let string = self.imageString, let url = URL(string: string) else { return }
            self.imageview.sd_setImage(with: url, placeholderImage: nil, options: .handleCookies) { (_ image, _, _, _) in
                if image != nil {
                    self.imageview.image = image
                }
            }
        }
    }
}
