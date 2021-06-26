//
//  RocketInfoTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit
import SDWebImage

protocol RocketInfoTableViewCellDelegate {
    func bookmarkAction(with rocketResponse : RocketResponse, sender : UIButton)
}

class RocketInfoTableViewCell: UITableViewCell {

    //MARK : - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var upcomingStatusLabel: UILabel!
    @IBOutlet weak var launchStatusLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    var delegate : RocketInfoTableViewCellDelegate?
    
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
        if let id = rocketResponse.id {
            self.bookmarkButton.isSelected = FirebaseStoreManager.shared.isRocketFavorited(id: id)
        } else {
            self.bookmarkButton.isSelected = false
        }
        
    }
    
    //MARK: - IBAction
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
        guard let rocketResponse = self.rocketResponse else { return  }
        self.delegate?.bookmarkAction(with: rocketResponse, sender: sender)
    }
    
}
