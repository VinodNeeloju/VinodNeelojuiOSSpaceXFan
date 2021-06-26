//
//  FavoriteRocketsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class FavoriteRocketsViewController: UIViewController {

    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> FavoriteRocketsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteRocketsViewController") as! FavoriteRocketsViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
