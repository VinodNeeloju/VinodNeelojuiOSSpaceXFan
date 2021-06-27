//
//  SignInViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit

class SignInViewModel: NSObject {

    ///This is a protocal SpaceXRocketsProtocal, this will have methodes those will trigger when the methode requires.
    private var delegate : SignInProtocal?
    
    /// Declaring override init() as private to avoid manual initlization.
    /// For initialization need to use init(with delegate : SpaceXRocketsProtocal)
    private override init() {
        super.init()
    }
    
    init(with delegate : SignInProtocal) {
        super.init()
        self.delegate = delegate
    }
    
    ///SignIn user with email and password authenticating with firebase
    public func signInUser(with email : String?, and password : String?) {
        guard let email = email, email.isValidEmail == true else {
            self.delegate?.requestFailed(with: "Please enter valid email", failed: 1)
            return
        }
        guard let password = password, password.isValidPassword == true else {
            self.delegate?.requestFailed(with: "Please enter valid password", failed: 2)
            return
        }
        self.delegate?.requestingServer()
        DataRepositoryManager.signInUser(with: email, password: password) { (_ status, _ error) in
            if status == false {
                self.delegate?.requestFailed(with: error ?? "Request failed please try after sometime", failed: 0)
            } else {
                FirebaseStoreManager.shared.fetchAllBookmarkIds { (_, _, _) in
                    self.delegate?.gotTheSuccessResponse()
                    NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "userSignedIn")))
                }
            }
        }
    }
    
    ///Creating user with email and password authenticating with firebase
    public func createAccount(with name: String?, email: String?, password: String?, confirmPassword : String?) {
        guard let name = name else {
            self.delegate?.requestFailed(with: "Please enter name", failed: 1)
            return
        }
        guard let email = email, email.isValidEmail == true else {
            self.delegate?.requestFailed(with: "Please enter valid email", failed: 2)
            return
        }
        guard let password = password, password.isValidPassword == true else {
            self.delegate?.requestFailed(with: "Please enter valid password", failed: 3)
            return
        }
        guard password == confirmPassword else {
            self.delegate?.requestFailed(with: "Please repeat the password", failed: 4)
            return
        }
        self.delegate?.requestingServer()
        DataRepositoryManager.createUser(with: email, password: password) { (_ status, _ error) in
            if status == false {
                self.delegate?.requestFailed(with: error ?? "Request failed please try after sometime", failed: 0)
            } else {
                FirebaseStoreManager.shared.createUserWithDetails(username: name)
                self.delegate?.gotTheSuccessResponse()
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "userSignedIn")))
            }
        }
    }
        
}

protocol SignInProtocal {
    
    
    ///This methode is for success response. Once we get the success response from the firebase api service this methode will excute.
    /**Success response from api request*/
    func gotTheSuccessResponse()
    
    ///This methode is for failure response. Once we get the failure response from the firebase api service this methode will excute.
    ///failed field is indicates which field failed condition.
    /**Failure response from api request with reason failed field 1- name 2- email, 3- password, 4- re enter password 0 - common field*/
    func requestFailed(with reason : String?, failed field : Int)
    
    ///Once alll the validations are successed and before goinng to hit the server this method will excute
    ///This method is to show the loading bar to block the ui
    func requestingServer()
    
    
}
