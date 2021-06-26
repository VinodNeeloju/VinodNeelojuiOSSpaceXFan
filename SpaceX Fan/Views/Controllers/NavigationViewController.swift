//
//  NavigationViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class NavigationViewController: UINavigationController {
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> NavigationViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
        return vc
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ///Declaring delegate = self   to access and handle the navigation optional delegate methods
        ///Here we are using it to add navigation barbutton items
        self.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UINavigationControllerDelegate
extension NavigationViewController : UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        
        if viewController.isKind(of: TabbarViewController.self) {
            self.addSignOutBarbuttonItemToTabbarController()
        }
        self.navigationBar.isHidden = false
        self.interactivePopGestureRecognizer?.isEnabled = false
        if viewController.isKind(of: RocketDetailsViewController.self) {
            self.navigationBar.isHidden = true
        }
        
    }
  
    ///This method is to dismiss the viewcontroller.
    ///This action is from navigation barbutton item
    @objc func closeButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
