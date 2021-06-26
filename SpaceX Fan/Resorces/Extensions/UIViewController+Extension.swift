//
//  UIViewcontroller+Extension.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import Foundation

extension UIViewController {
    
    public func checkIsUserAuthorized(_ complation : ((_ result : Bool) -> ())?) {
        if FirebaseAuthenticationManager.shared.isUserExist == true {
            // Autharised firebase user
            // Now check for local authentication
            if LocalAuthenticationManager.shared.isUserAuthenticated == true {
                complation?(true)
            } else {
                // User doesn't authenticated(fingerprint/faceId). show the fingerpint popup
                self.showFingerPrintPopup(complation)
                complation?(false)
            }
        } else {
            //Show firebase authentication scereens. i.e, Signup or signin screens
            self.showAuthenticatePopup()
            complation?(false)
        }
    }
    
    ///This method open fingerprint/faceid recognation popup
    private func showFingerPrintPopup(_ complation : ((_ result : Bool) -> ())?) {
        LocalAuthenticationManager.shared.showFingerPrintPopup(complation: { (_ status, _ error) in
            if status == true {
                //Successfully authenticated so move to favourites screen forcefully.
                complation?(true)
            } else {
                complation?(false)
                Constants.KeyWindow?.makeToast(error)
            }
        })
    }
    
    ///This method open the authentication popup to signin or create an account in firebase.
    private func showAuthenticatePopup() {
        let vc = AuthenticateOptionsViewController.create()
        self.present(vc, animated: false, completion: nil)
    }
}
