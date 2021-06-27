//
//  RocketDetailsViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 26/06/21.
//

import UIKit

class RocketDetailsViewModel: NSObject {
    ///This is a protocal SpaceXRocketsProtocal, this will have methodes those will trigger when the methode requires.
    private var delegate : RocketDetailsProtocal?
    
    public var rocketResponse : RocketResponse?
    
    public func setDelegate(_ delegate : RocketDetailsProtocal) {
        self.delegate = delegate
        self.arrangeLinksList()
    }
    
    private func arrangeLinksList() {
        var list = [[String : String]]()
        if let links = rocketResponse?.links {
            if let id = links.youtube_id {
                list.append([Constants.WebsiteLinks.Youtube : "https://www.youtube.com/watch?v=\(id)"])
            }
            if let id = links.reddit?.launch {
                list.append([Constants.WebsiteLinks.Launch : id])
            }
            if let id = links.wikipedia {
                list.append([Constants.WebsiteLinks.Wikipedia : id])
            }
            if let id = links.webcast {
                list.append([Constants.WebsiteLinks.Webcast : id])
            }
            if let id = links.article {
                list.append([Constants.WebsiteLinks.Article : id])
            }
        }
        self.linksList = list
    }
    
    public var linksList : [[String : String]]?
    
    public var isFavourited : Bool {
        guard let id = rocketResponse?.id else { return false }
        return FirebaseStoreManager.shared.isRocketFavorited(id: id)
    }
    
    public func favoriteRocket() {
        if let id = rocketResponse?.id {
            if FirebaseStoreManager.shared.isRocketFavorited(id: id) == true {
                self.unFavorite()
            } else {
                self.favorite()
            }
        } else {
            
        }
    }
    
    fileprivate func favorite() {
        if let uid = FirebaseAuthenticationManager.shared.user?.uid, let id = rocketResponse?.id {
            FirebaseStoreManager.shared.addBookmark(with: uid, bookmarkId: id)
            self.delegate?.favoriteStatusUpdated()
        }
    }
    
    fileprivate func unFavorite() {
        if let uid = FirebaseAuthenticationManager.shared.user?.uid, let id = rocketResponse?.id {
            FirebaseStoreManager.shared.removeBookmark(with: uid, bookmarkId: id)
            self.delegate?.favoriteStatusUpdated()
        }
    }
}




protocol RocketDetailsProtocal {
    
    ///This methode is for success response. Once we get the success response from the firebase api service this methode will excute.
    /**Success response from api request*/
//    func gotTheSuccessResponse()
    
    ///This methode is for failure response. Once we get the failure response from the firebase api service this methode will excute.
    ///failed field is indicates which field failed condition.
    /**Failure response from api request with reason failed field 1- email, 2- password, 0 - common field*/
//    func requestFailed(with reason : String?, failed field : Int)
    
    func favoriteStatusUpdated()
}
