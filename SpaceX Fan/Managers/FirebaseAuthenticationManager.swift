//
//  FirebaseAuthenticationManager.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit
import Firebase
import FirebaseAuth

class FirebaseAuthenticationManager: NSObject {

    //MARK: initializations
    ///Overriding this method with private is to use shared property( i.e, Singleton ) forcefully
    private override init() {
        super .init()
    }
    
    ///This varable create a singleton object
    static var shared = FirebaseAuthenticationManager()
    
    //MARK: User properties
    ///This var will returns true if the user already logged in the app, If not it will returns false
    var isUserExist : Bool? {
        let auth = Auth.auth()
        
        return auth.currentUser != nil
    }
    
    ///This var will returns the User object if already logged in, If not returns nil
    var user : User? {
        return Auth.auth().currentUser
    }
    
    //MARK: Authentication Methods
    ///This method hit the firebase to create a firebase account with the given email and password
    /// Once the email added in the firebase this method will return two things via complation handler
    /// 1. Bool flag of success/failure status, i.e, status
    /// 2. String of success or failure reason. i.e, message
    public func createFirebseAccount(with email : String?, password : String?, complation : ((_ status : Bool, _ message : String) -> ())?){
        guard let email = email, email.isValidEmail == true else {
            complation?(false, "Please enter valid email")
            return
        }
        guard let password = password, password.isValidPassword == true else {
            complation?(false, "Please enter valid password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if authDataResult != nil, error == nil {
                complation?(true, "Succesfully createdAccount")
            } else {
                complation?(false, "Failed with reason\(error?.localizedDescription ?? "")")
            }
        }
    }
    
    ///This method hit the firebase to sighIn to firebase account with the given email and password
    ///If the given email and password is already registered in the firebase databse then will get AuthDataResult or else will get error with description
    /// this method will return two things via complation handler
    /// 1. Bool flag of success/failure status, i.e, status
    /// 2. String of success or failure reason. i.e, message
    public func signInFirebseAccount(with email : String?, password : String?, complation : ((_ status : Bool, _ message : String) -> ())?){
        guard let email = email, email.isValidEmail == true else {
            complation?(false, "Please enter valid email")
            return
        }
        guard let password = password, password.isValidPassword == true else {
            complation?(false, "Please enter valid password")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if authDataResult != nil, error == nil {
                complation?(true, "Succesfully signedIn")
            } else {
                complation?(false, "\(error?.localizedDescription ?? "")")
            }
        }
    }
    
    ///This method is to signout the user, This will clear all the credentials and all.
    public func signoutFirebase() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            LocalAuthenticationManager.shared.isUserAuthenticated = false
            FirebaseStoreManager.shared.clearLocalStoreData()
        } catch let signOutError as NSError {
            print("signout error:\(signOutError)")
        }
    }
    
}
