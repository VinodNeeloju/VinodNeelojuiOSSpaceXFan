//
//  DetailsVCDetailsTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class DetailsVCDetailsTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    ///RocketResponse to show the detail text of the rocket
    public var rocketResponse : RocketResponse? {
        didSet {
            self.detailsLabel.text = rocketResponse?.details
        }
    }
}
