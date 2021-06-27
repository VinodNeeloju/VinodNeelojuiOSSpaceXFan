//
//  DetailVCImageCollectionViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class DetailVCImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var rocketImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    ///String of the downloadable image
    public var imageString : String? {
        didSet {
            self.setImage()
        }
    }
    
    /// This is to download and show the image in Image view
    private func setImage() {
        if let string = imageString, let url = URL(string: string) {
            self.rocketImageView.sd_setImage(with: url, placeholderImage: nil, options: .handleCookies) { (_ image, _, _, _) in
                if image != nil {
                    self.rocketImageView.image = image
                }
            }
        }
    }
    
}
