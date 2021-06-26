//
//  TabbarViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class TabbarViewController: UITabBarController {
  
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> TabbarViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        return vc
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ///Declaring delegate = self   to access and handle the UITabBarController  delegate methods
        ///Here we are using it to control and authenticate to access the few features ( i.e, Favourites ). If the user is not signed in.
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

//MARK: - UITabBarControllerDelegate
extension TabbarViewController : UITabBarControllerDelegate {
    ///This is method is too show the viewController or not. This method needs a return value of boolian.
    ///This will help us to check restict the screen for authentication...
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.isKind(of: FavoriteRocketsViewController.self) {
            ///Check if ther user is authorized user or not
            let flag = self.checkIsUserAuthorized { (_ autherizedUser) in
                if autherizedUser == true {
                    DispatchQueue.main.async {
                        self.selectedIndex = 1
                    }
                }
            }
            return flag
        }
        FirebaseStoreManager.shared.fetchAllBookmarkIds(nil)
        return true
    }
}
