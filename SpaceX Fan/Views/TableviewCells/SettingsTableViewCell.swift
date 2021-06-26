//
//  SettingsTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 26/06/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
