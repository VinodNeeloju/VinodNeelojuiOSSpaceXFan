//
//  RocketInfoTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit
import SDWebImage

class RocketInfoTableViewCell: UITableViewCell {

    //MARK : - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var upcomingStatusLabel: UILabel!
    @IBOutlet weak var launchStatusLabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    ///This is the object response of the rocket...
    public var rocketResponse : RocketResponse? {
        didSet {
            self.setValues()
        }
    }
    private func setValues() {
        guard let rocketResponse = rocketResponse else { return }
        
        if let imageString = rocketResponse.links?.patch?.small, let url = URL(string: imageString) {
            self.imageview.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "rocket"), options: .handleCookies) { (_ image, _, _, _) in
                self.imageview.image = image
            }
        } else {
            self.imageview.image = #imageLiteral(resourceName: "rocket")
        }
        
        if let name = rocketResponse.name {
            self.nameLabel.text = "Name: \(name)"
        }
        if let flight_number = rocketResponse.flight_number {
            self.flightNumberLabel.text = "Flight number: \(flight_number)"
        } else {
            self.flightNumberLabel.text = ""
        }
        if let upcoming = rocketResponse.upcoming {
            self.upcomingStatusLabel.text = upcoming == true ? "Upcoming launch" : "Launched"
            if upcoming == false, let status = rocketResponse.success {
                self.launchStatusLabel.text = status == false ? "Failed" : "Success"
                self.launchStatusLabel.textColor = status == false ? Constants.Colors.Red : Constants.Colors.Green
            } else {
                self.launchStatusLabel.text = ""
            }
        } else {
            self.upcomingStatusLabel.text = ""
            self.launchStatusLabel.text = ""
        }
    }
    
    //MARK: - IBAction
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
        UIApplication.topViewController()?.checkIsUserAuthorized({ (_ autherizedUser) in
            if autherizedUser == true {
                sender.isSelected = !sender.isSelected
            }
        })
    }
    
}
