//
//  FirebaseStoreManager.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 26/06/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseStoreManager: NSObject {
    
    ///Collection paths of the firebase firestore
    struct Collections {
        static var rootCollection : String {
            return Constants.Apis.isLive == true ? live : dev
        }
        static let dev = "dev"
        static let live = "live"
        static let userslist = "userslist"
        static let bookmarks = "bookmarks"
        
        static func bookmarksPath(userId : String) -> String {
            return rootCollection + "/\(Documents.users)/\(userslist)/\(userId)/\(bookmarks)/"
        }
        static func userIdPath(userId : String) -> String {
            return rootCollection + "/\(Documents.users)/\(userslist)/\(userId)/"
        }
    }

    ///Document paths of the firebase firestore
    struct Documents {
        static let users = "users"
    }
    
    ///User keys of user document
    ///We can store the user info in firestore by using this keys i
    struct UserDetailsKeys {
        static let email = "email"
        static let name = "name"
        static let userId = "userId"
    }
    
    //MARK: initializations
    ///Overriding this method with private is to use shared property( i.e, Singleton ) forcefully.
    private override init() {
        super .init()
    }
    
    ///This varable create a singleton object
    static var shared = FirebaseStoreManager()
    
    private let firebaseDB = Firestore.firestore()
    private var bookmarkIds : [String]?
    
    ///This  is to check the specifict rocket is bookmarked or not in firebase firestore
    public func isRocketFavorited(id : String) -> Bool {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return false }
        guard let bookmarkIds = self.bookmarkIds else { return false }
        return bookmarkIds.contains(id)
    }
    
    ///This method is to fetch all the bookmark ids which are stored in firebase firestore
    public func fetchAllBookmarkIds(_ complation : ((_ status : Bool?, _ bookmarkIds  :[String]?, _ errorMessage : String?) -> ())?) {
        guard let userId = FirebaseAuthenticationManager.shared.user?.uid else {
            complation?(false, nil, "Login to access this feature")
            return
        }
        firebaseDB.collection(Collections.rootCollection).document(Documents.users).collection(Collections.userslist).document(userId).collection(Collections.bookmarks).getDocuments { (querySnapshot, error) in
            if let err = error {
                complation?(false, nil, err.localizedDescription)
            }
            else {
                if let querySnapshot = querySnapshot {
                    var ids : [String]?
                    for document in querySnapshot.documents {
                        if ids == nil { ids = [String]() }
                        ids?.append(document.documentID)
                    }
                    self.bookmarkIds = ids
                    complation?(true, ids, nil)
                } else {
                    complation?(false, nil, error?.localizedDescription ?? "Something went wrong please try again")
                }
            }
        }
    }
    
    ///This method will create a path in the  fire store and store the data of the user.
    public func createUserWithDetails(username : String) {
        guard let user = FirebaseAuthenticationManager.shared.user else { return }
        
        let data : [String : Any] = [user.uid : [UserDetailsKeys.email : user.email, UserDetailsKeys.name : username, UserDetailsKeys.userId : user.uid]]
        
        firebaseDB.collection(Collections.rootCollection).document(Documents.users).collection(Collections.userslist).addDocument(data: data)
    }
    
    ///Add bookmark
    ///This is to add the document id (bookmark id) in the firestore
    public func addBookmark(with userid : String, bookmarkId : String) {
        self.bookmarkIds?.append(bookmarkId)
        firebaseDB.collection(Collections.bookmarksPath(userId: userid)).document(bookmarkId).setData(["bookmarked" : true])
        FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Favorite)
    }
    
    ///Removing bookmark
    ///This is to delete the document id (bookmark id) from the firestore
    public func removeBookmark(with userid : String, bookmarkId : String) {
        self.bookmarkIds = self.bookmarkIds?.filter { $0 != bookmarkId }
        firebaseDB.collection(Collections.bookmarksPath(userId: userid)).document(bookmarkId).delete()
        FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.Unfavorite)
    }

    ///This method is to clear local data i.e, bookmarksIs which are stored in bookmarkIds object.
    func clearLocalStoreData() {
        self.bookmarkIds = nil
    }
    
}
