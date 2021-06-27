//
//  UIViewcontroller+Extension.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import Foundation

extension UIViewController {
    
    public func checkIsUserAuthorized(_ complation : ((_ result : Bool) -> ())?) -> Bool {
        if FirebaseAuthenticationManager.shared.isUserExist == true {
            // Autharised firebase user
            // Now check for local authentication
            if LocalAuthenticationManager.shared.isUserAuthenticated == true {
                complation?(true)
                return true
            } else {
                // User doesn't authenticated(fingerprint/faceId). show the fingerpint popup
                self.showFingerPrintPopup(complation)
                complation?(false)
                return false
            }
        } else {
            //Show firebase authentication scereens. i.e, Signup or signin screens
            self.showAuthenticatePopup()
            complation?(false)
            return false
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
    
    
    ///Adding settings barbutton item to Viewcontroller navigationItem
    ///Using customeview to change to show custome color of icon
    public func addSignOutBarbuttonItemToTabbarController() {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "logout"), for: .normal)
        button.addTarget(self, action: #selector(signoutButtonAction), for: .touchUpInside)
        button.tintColor = UIColor.white
        let barButton = UIBarButtonItem.init(customView: button)
        let viewController = (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.topViewController        
        viewController?.navigationItem.rightBarButtonItem  = barButton
    }
    
      ///This method is to open confirm popup of signout
      ///This action is from navigation barbutton item
      @objc func signoutButtonAction() {
          guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
          let alertController = UIAlertController.init(title: "Sign out", message: "Are you sure do you want to sign out", preferredStyle: .alert)
          alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_ alert) in
              FirebaseAuthenticationManager.shared.signoutFirebase()
              self.removeSignoutButton()
              alertController.dismiss(animated: true, completion: nil)
          }))
          alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_ alert) in
              alertController.dismiss(animated: true, completion: nil)
          }))
          alertController.view.tintColor = UIColor.black
          if let popoverController = alertController.popoverPresentationController {
              popoverController.sourceView = self.view
              popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
      }
    
    
    private func removeSignoutButton() {
        guard let viewController = UIApplication.topViewController() else { return }
        let tabbarController = viewController.tabBarController
        viewController.viewWillAppear(true)
        tabbarController?.navigationItem.rightBarButtonItem = nil
        tabbarController?.selectedIndex = 0
    }
    
}
