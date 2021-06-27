//
//  DetailsVCInternalLinksTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class DetailsVCInternalLinksTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    ///Welink Object to show which link it is... ex: Youtube
    public var webLinkObject : [String : String]? {
        didSet {
            var color : UIColor?
            let key = webLinkObject?.keys.first
            switch key {
            case Constants.WebsiteLinks.Youtube:
                color = Constants.Colors.WebsiteLinks.Youtube
            case Constants.WebsiteLinks.Article:
                color = Constants.Colors.WebsiteLinks.Article
            case Constants.WebsiteLinks.Launch:
                color = Constants.Colors.WebsiteLinks.Launch
            case Constants.WebsiteLinks.Webcast:
                color = Constants.Colors.WebsiteLinks.Webcast
            case Constants.WebsiteLinks.Wikipedia:
                color = Constants.Colors.WebsiteLinks.Wikipedia
            default:
                color = Constants.Colors.WebsiteLinks.Wikipedia
            }
            self.button.setTitle(key, for: .normal)
            self.button.borderWidth = 1
            self.button.borderColor = color!
            self.button.setTitleColor(color!, for: .normal)
        }
    }
    
    //MARK: - IBAction
    ///Button action of links
    @IBAction func buttonaction(_ sender: Any) {
        guard let value = webLinkObject?.values.first, let url = URL(string: value) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        guard let key = webLinkObject?.keys.first else { return }
        switch key {
        case Constants.WebsiteLinks.Youtube:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Youtube)
        case Constants.WebsiteLinks.Article:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Artical)
        case Constants.WebsiteLinks.Launch:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Launch)
        case Constants.WebsiteLinks.Webcast:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.WebCast)
        case Constants.WebsiteLinks.Wikipedia:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Wikipedia)
        default:
            FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Wikipedia)
        }
    }
    
}
