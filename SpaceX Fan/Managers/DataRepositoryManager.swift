//
//  DataRepositoryManager.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit
import Firebase
import FirebaseAuth

class DataRepositoryManager: NSObject {

    ///This method fetch the list of all rockets from the service api
    ///After getting the response from the server this method will return the response by using closer
    ///Return types are three types status, response and error.
    static func fetchSpaceXRocketsList(_ complation : ((_ status : Bool, _ response : [RocketResponse]?, _ error : String?) -> ())?) {
        ServiceManager.request(with: .Get, urlString: Constants.Apis.AllRocketListUrl) { (_ status, _ error, _ data) in
            guard status == true, let data = data else {
                complation?(status, nil, error)
                return
            }
            do {
                let model = try JSONDecoder().decode([RocketResponse].self, from: data)
                complation?(true, model, nil)
            }
            catch {
                print(error)
                complation?(false, nil, error.localizedDescription)
            }
        }
    }
    
    ///This method fetch the list of all upcoming rockets from the service api
    ///After getting the response from the server this method will return the response by using closer
    ///Return types are three: status, response and error.
    static func fetchUpcomingSpaceXRocketsList(_ complation : ((_ status : Bool, _ response : [RocketResponse]?, _ error : String?) -> ())?) {
        ServiceManager.request(with: .Get, urlString: Constants.Apis.UpcomingRocketListUrl) { (_ status, _ error, _ data) in
            guard status == true, let data = data else {
                complation?(status, nil, error)
                return
            }
            do {
                let model = try JSONDecoder().decode([RocketResponse].self, from: data)
                complation?(true, model, nil)
            }
            catch {
                print(error)
                complation?(false, nil, error.localizedDescription)
            }
        }
    }
    
    ///This methode will signin the user in firebase with given email and password.
    static func signInUser(with email : String, password : String, _ complation : ((_ status : Bool, _ error : String?) -> ())?) {
        FirebaseAuthenticationManager.shared.signInFirebseAccount(with: email, password: password, complation: complation)
    }
    
    ///This methode will create an user in firebase with given email and password.
    static func createUser(with email : String, password : String, _ complation : ((_ status : Bool, _ error : String?) -> ())?) {
        FirebaseAuthenticationManager.shared.createFirebseAccount(with: email, password: password, complation: complation)
    }
    
}
