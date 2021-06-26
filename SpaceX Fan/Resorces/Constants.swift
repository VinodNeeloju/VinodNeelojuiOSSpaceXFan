//
//  Constants.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class Constants: NSObject {

    static let KeyWindow = UIApplication.shared.keyWindow
    
    struct Apis {
        
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
    }
}
