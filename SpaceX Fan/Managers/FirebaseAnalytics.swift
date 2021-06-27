//
//  FirebaseAnalytics.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit
import Firebase


class FirebaseAnalytics: NSObject {
    
    ///This are screen names which are there in SpaceX Fan app
    struct ScreenNames {
        static let AllRockets = "all_rockets_screen"
        static let FavoriteRockets = "favorites_rockets_screen"
        static let UpcomingRockets = "upcoming_rockets_screen"
        static let RocketDetails = "rocket_details_screen"
        static let SignIn = "signin_screen"
        static let CreateAccount = "create_account_screen"
        static let ImagePreview = "image_preview_screen"
    }
    
    
    ///This are some custom event names
    struct EventName {
        static let Favorite = "favorite_action"
        static let Unfavorite = "unfavorite_action"
        static let SignIn = "sign_action"
        static let CreateAccount = "create_account_action"
        static let SignOut = "signout_action"
        static let Youtube = "youtube_link_action"
        static let Launch = "launch_event_link_action"
        static let Wikipedia = "wikipedia_link_action"
        static let WebCast = "webcast_link_action"
        static let Artical = "artical_link_action"
    }
    
    ///This method is to store the event analytics performed by the user  in firebase analytics
    ///With this we can track the user movment and analyse what user is doing
    static func logEvent(event name : String){
        Analytics.logEvent(name, parameters: ["click_actions" : name])
    }
    
    ///This method is to store the screen analytics in firebase
    ///With this we can track the user movment and analyse what user is doing
    static func logScreen(name : String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: ["screen" : name])
    }
}
