//
//  UpcomingLaunchesViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class UpcomingLaunchesViewModel: NSObject {
    
    ///This is a protocal SpaceXRocketsProtocal, this will have methodes those will trigger when the methode requires.
    private var delegate : UpcomingLaunchesProtocal?
    
    /// Declaring override init() as private to avoid manual initlization.
    /// For initialization need to use init(with delegate : SpaceXRocketsProtocal)
    private override init() {
        super.init()
    }
    
    init(with delegate : UpcomingLaunchesProtocal) {
        super.init()
        self.delegate = delegate
        NotificationCenter.default.addObserver(self, selector: #selector(userSignedIn), name: NSNotification.Name(rawValue: "userSignedIn"), object: nil)
    }
    
    public var rocketsList : [RocketResponse]?
    
    /// To fetch all the rocket list from the server.
    public func fetchRocketsList() {
        DataRepositoryManager.fetchUpcomingSpaceXRocketsList{ (_ status, _ list, _ error) in
            self.fetchFavouritesList()
            if status, let list = list {
                self.rocketsList = list
            } else {
                self.delegate?.requestFailed(with: error)
            }
        }
    }
    
    ///Fetching the favourite list from firestore to show the favourite list and favorite status in the rockets list
    private func fetchFavouritesList() {
        FirebaseStoreManager.shared.fetchAllBookmarkIds { (_ status, _ ids, _ err) in
            self.delegate?.gotTheResponse()
        }
    }
    
    ///This is the notification observer to update the ui according to login status
    @objc func userSignedIn() {
        self.delegate?.gotTheResponse()
    }
    
}


protocol UpcomingLaunchesProtocal {
    ///This methode is for success response. Once we get the success response from the api service this methode will excute.
    /**Success response from api request*/
    func gotTheResponse()
    
    ///This methode is for failure response. Once we get the failure response from the api service this methode will excute.
    /**Failure response from api request with reason*/
    func requestFailed(with reason : String?)
}
