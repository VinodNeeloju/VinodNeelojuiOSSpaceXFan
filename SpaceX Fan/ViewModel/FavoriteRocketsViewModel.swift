//
//  FavoriteRocketsViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class FavoriteRocketsViewModel: NSObject {
    
    ///This is a protocal SpaceXRocketsProtocal, this will have methodes those will trigger when the methode requires.
    private var delegate : FavouriteRocketsProtocal?
    
    /// Declaring override init() as private to avoid manual initlization.
    /// For initialization need to use init(with delegate : SpaceXRocketsProtocal)
    private override init() {
        super.init()
    }
    
    init(with delegate : FavouriteRocketsProtocal) {
        super.init()
        self.delegate = delegate
    }
    
    private var rocketsList : [RocketResponse]?
    public var favouritesList : [RocketResponse]?
    private var bookmarkRocketsIds : [String]?
    
    private var firebaseListFlag : Bool = false
    private var rocketsListFlag : Bool = false
    
    private func fetchBookmarksIdsList() {
        FirebaseStoreManager.shared.fetchAllBookmarkIds { (_ status, _ bookmarkIds, _ errorMessage) in
            self.bookmarkRocketsIds = bookmarkIds ?? [""]
            self.arrangeFavouritesData()
        }
    }
    
    public func fetchAllFavoriteRocketsList() {
        self.fetchBookmarksIdsList()
        if self.rocketsList == nil {
            DataRepositoryManager.fetchSpaceXRocketsList { (_ status, _ rocketResponses, _ errorMessage) in
                self.rocketsList = rocketResponses ?? [RocketResponse]()
                self.arrangeFavouritesData()
            }
        }
    }
    
    private func arrangeFavouritesData() {
        if let ids = self.bookmarkRocketsIds, let rocketsList = self.rocketsList {
            let filterList = rocketsList.filter { ids.contains($0.id ?? "") }
            self.favouritesList = filterList
            self.delegate?.gotTheResponse()
        }
    }
    
    public func indexOfObject(_ rocketResponse : RocketResponse) -> Int? {
        if let index = self.favouritesList!.firstIndex(where: { $0.id == rocketResponse.id } ) {
            return index
        }
        return 0
    }
    
    public func removeRocketFromFavoriteList(with indexPath : IndexPath, _ complation : (() -> ())?) {
        if let rocketResponse = favouritesList?[indexPath.row] {
            if let uid = FirebaseAuthenticationManager.shared.user?.uid, let id = rocketResponse.id {
                FirebaseStoreManager.shared.removeBookmark(with: uid, bookmarkId: id)
            }
            favouritesList?.remove(at: indexPath.row)
            complation?()
        } else {
            complation?()
        }
    }
}

protocol FavouriteRocketsProtocal {
    ///This methode is for success response. Once we get the success response from the api service this methode will excute.
    /**Success response from api request*/
    func gotTheResponse()
    
    ///This methode is for failure response. Once we get the failure response from the api service this methode will excute.
    /**Failure response from api request with reason*/
    func requestFailed(with reason : String?)
}
