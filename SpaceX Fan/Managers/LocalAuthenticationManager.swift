//
//  LocalAuthenticationManager.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit
import LocalAuthentication

class LocalAuthenticationManager: NSObject {

    //MARK: initializations
    ///Overriding this method with private is to use shared property( i.e, Singleton ) forcefully.
    private override init() {
        super .init()
    }
    
    ///This varable create a singleton object
    static var shared = LocalAuthenticationManager()
    
    ///This is a local varible to check the user already authenticated with fingerprint or faceId.
    var isUserAuthenticated : Bool?
    
    //MARK: Authentication methods
    
    ///This method trigger LAContext to validate the fingerpint or face recognizer
    ///This method returns two variables with the help of complation handler
    /// 1. Bool flag of success/failure status, i.e, status
    /// 2. String of success or failure reason. i.e, message
    func showFingerPrintPopup(complation : ((_ status : Bool, _ message : String) -> ())?) {
        
        let myContext = LAContext()
        let myLocalizedReasonString = "SpaceX Fan need access for authentication"
        
        var authError: NSError?
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                if success {
                    //"User authenticated successfully!"
                    self.isUserAuthenticated = true
                    complation?(true, "successfully athenticated")
                } else {
                    // User did not authenticate successfully, look at error and take appropriate action
                    // self.failureMessage(message: "Sorry!!... User did not authenticate successfully")
                    self.errorMessage(error: evaluateError as! LAError, complation)
                }
            }
        } else {
            complation?(false, "Finger print not activate.")
        }
    }
    
    ///Reason for error is capturing here...
    ///Checking the reason by using the code from LAError.
    func errorMessage(error:LAError, _ complation : ((_ status : Bool, _ message : String) -> ())?) {
            var message = ""
            switch error.code {
            case LAError.authenticationFailed:
                message = "Authentication Failed."
                break
            case LAError.userCancel:
                message = "User Cancelled."
                break
            case LAError.userFallback:
                message = "Fallback authentication mechanism selected."
                break
            case LAError.touchIDNotEnrolled:
                message = "Touch ID is not enrolled."

            case LAError.passcodeNotSet:
                message = "Passcode is not set on the device."
                break
            case LAError.systemCancel:
                message = "System Cancelled."
                break
            default:
                message = error.localizedDescription
            }
            complation?(false, message)
        }
    
}
