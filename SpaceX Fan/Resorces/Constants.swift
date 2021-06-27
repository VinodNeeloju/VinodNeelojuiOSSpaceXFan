//
//  Constants.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class Constants: NSObject {

    static let KeyWindow = UIApplication.shared.keyWindow
    
    static let Loader = LoadingViewController.create()
    
    struct Apis {
        
        static var isLive : Bool {
            return false
        }
        
        static let BaseUrl = "https://api.spacexdata.com/v4"
        static let AllRocketListUrl = BaseUrl + "/launches"
        static let UpcomingRocketListUrl = BaseUrl + "/launches/upcoming"
        
    }
    
    struct Bounds {
        static let size = UIScreen.main.bounds.size
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
        static let bounds = UIScreen.main.bounds
        static let tabbarHeight : CGFloat = 49.0
    }
    
    struct Colors {
        static let Green = UIColor.init(hexString: "#039640", alpha: 1)
        static let Red = UIColor.init(hexString: "#d13b3b", alpha: 1)
        static let AppBlue = UIColor.init(hexString: "#001C44", alpha: 1)
        struct WebsiteLinks {
            static let Youtube = UIColor.init(hexString: "#d40b0b", alpha: 1)
            static let Launch = UIColor.init(hexString: "#0b8009", alpha: 1)
            static let Wikipedia = UIColor.init(hexString: "#0d7cd6", alpha: 1)
            static let Webcast = UIColor.init(hexString: "#057870", alpha: 1)
            static let Article = UIColor.init(hexString: "#db5807", alpha: 1)
        }
    }
    
    struct WebsiteLinks {
        static let Youtube = "Youtube"
        static let Launch = "Launch"
        static let Wikipedia = "Wikipedia"
        static let Webcast = "Webcast"
        static let Article = "Article"
    }
    
}
