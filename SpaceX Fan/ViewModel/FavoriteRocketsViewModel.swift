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
    
    ///This method is to fetch the favorite lists from firestore
    private func fetchBookmarksIdsList() {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
        FirebaseStoreManager.shared.fetchAllBookmarkIds { (_ status, _ bookmarkIds, _ errorMessage) in
            self.bookmarkRocketsIds = bookmarkIds ?? [""]
            self.arrangeFavouritesData()
        }
    }
    
    ///This method is to fetch all the favorite rockets list
    public func fetchAllFavoriteRocketsList() {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
        self.fetchBookmarksIdsList()
        if self.rocketsList == nil {
            DataRepositoryManager.fetchSpaceXRocketsList { (_ status, _ rocketResponses, _ errorMessage) in
                self.rocketsList = rocketResponses ?? [RocketResponse]()
                self.arrangeFavouritesData()
            }
        }
    }
    
    ///This is to arrange favorites data
    ///Fetching the Ids and Total list of rocktes and filtering to get the favorited list of rockets
    private func arrangeFavouritesData() {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
        if let ids = self.bookmarkRocketsIds, let rocketsList = self.rocketsList {
            let filterList = rocketsList.filter { ids.contains($0.id ?? "") }
            self.favouritesList = filterList
            self.delegate?.gotTheResponse()
        }
    }
    
    ///Fetching the index of the object from favorite list
    public func indexOfObject(_ rocketResponse : RocketResponse) -> Int? {
        if let index = self.favouritesList!.firstIndex(where: { $0.id == rocketResponse.id } ) {
            return index
        }
        return 0
    }
    
    ///This is to remove rocket from favorite list
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
