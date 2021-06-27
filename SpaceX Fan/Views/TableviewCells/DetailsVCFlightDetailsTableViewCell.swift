//
//  DetailsVCFlightDetailsTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class DetailsVCFlightDetailsTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    
    @IBOutlet weak var launchStatusLabel: UILabel!
    
    ///This object is to set the the data
    public var rocketResponse : RocketResponse? {
        didSet {
            self.setData()
        }
    }
    
    ///This method is to set all the data of the rocket to show the info...
    private func setData() {
        if let imageString = rocketResponse?.links?.patch?.small, let url = URL(string: imageString) {
            self.rocketImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "rocket"), options: .handleCookies) { (_ image, _, _, _) in
                self.rocketImageView.image = image
            }
        } else {
            self.rocketImageView.image = #imageLiteral(resourceName: "rocket")
        }
        
        if let flight_number = rocketResponse?.flight_number {
            self.flightNumberLabel.text = "Flight number: \(flight_number)"
        } else {
            self.flightNumberLabel.text = ""
        }
        if let upcoming = rocketResponse?.upcoming {
            self.eventTypeLabel.text = upcoming == true ? "Upcoming launch" : "Launched"
            if upcoming == false, let status = rocketResponse?.success {
                self.launchStatusLabel.text = status == false ? "Failed" : "Success"
                self.launchStatusLabel.textColor = status == false ? Constants.Colors.Red : Constants.Colors.Green
            } else {
                self.launchStatusLabel.text = ""
            }
        } else {
            self.eventTypeLabel.text = ""
            self.launchStatusLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
