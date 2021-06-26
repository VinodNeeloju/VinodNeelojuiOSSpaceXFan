//
//  SpaceXRocketsViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class SpaceXRocketsViewModel: NSObject {
    
    ///This is a protocal SpaceXRocketsProtocal, this will have methodes those will trigger when the methode requires.
    private var delegate : SpaceXRocketsProtocal?
    
    /// Declaring override init() as private to avoid manual initlization.
    /// For initialization need to use init(with delegate : SpaceXRocketsProtocal)
    private override init() {
        super.init()
    }
    
    init(with delegate : SpaceXRocketsProtocal) {
        super.init()
        self.delegate = delegate
    }
    
    public var rocketsList : [RocketResponse]?
    
    /// To fetch all the rocket list from the server.
    public func fetchRocketsList() {
        DataRepositoryManager.fetchSpaceXRocketsList { (_ status, _ list, _ error) in
            if status, let list = list {
                self.rocketsList = list
                self.delegate?.gotTheResponse()
            } else {
                self.delegate?.requestFailed(with: error)
            }
        }
    }
}

protocol SpaceXRocketsProtocal {
    ///This methode is for success response. Once we get the success response from the api service this methode will excute.
    /**Success response from api request*/
    func gotTheResponse()
    
    ///This methode is for failure response. Once we get the failure response from the api service this methode will excute.
    /**Failure response from api request with reason*/
    func requestFailed(with reason : String?)
}
