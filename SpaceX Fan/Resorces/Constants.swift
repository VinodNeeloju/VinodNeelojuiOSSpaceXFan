//
//  Constants.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class Constants: NSObject {

    ///This is a shortcut to access the keywindow to perform some specific operations
    static let KeyWindow = UIApplication.shared.keyWindow
    
    ///This is a shortcut to access the loading view controllr to show/ hide it.
    static let Loader = LoadingViewController.create()
    
    ///Api endpoints of the app
    ///All end points we can see here which are used in the app
    struct Apis {
        
        static var isLive : Bool {
            return true
        }
        
        static let BaseUrl = "https://api.spacexdata.com/v4"
        static let AllRocketListUrl = BaseUrl + "/launches"
        static let UpcomingRocketListUrl = BaseUrl + "/launches/upcoming"
        
    }
    
    ///Bounds of the UIScreen to keep it handy
    struct Bounds {
        static let size = UIScreen.main.bounds.size
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
        static let bounds = UIScreen.main.bounds
        static let tabbarHeight : CGFloat = 49.0
    }
    
    ///Static colors used in the app
    struct Colors {
        static let Green = UIColor.init(hexString: "#039640", alpha: 1)
        static let Teal = UIColor.init(hexString: "#34ECFF", alpha: 1)
        static let Red = UIColor.init(hexString: "#ed5700", alpha: 1)
        static let AppBlue = UIColor.init(hexString: "#001C44", alpha: 1)
        struct WebsiteLinks {
            static let Youtube = UIColor.init(hexString: "#d40b0b", alpha: 1)
            static let Launch = UIColor.init(hexString: "#0b8009", alpha: 1)
            static let Wikipedia = UIColor.init(hexString: "#0d7cd6", alpha: 1)
            static let Webcast = UIColor.init(hexString: "#57586D", alpha: 1)
            static let Article = UIColor.init(hexString: "#db5807", alpha: 1)
        }
    }
    
    ///Names of the wesite links which we are using in detail screen
    struct WebsiteLinks {
        static let Youtube = "Youtube"
        static let Launch = "Launch"
        static let Wikipedia = "Wikipedia"
        static let Webcast = "Webcast"
        static let Article = "Article"
    }
    
    static let PasswordMinimumLegth = 6
}
