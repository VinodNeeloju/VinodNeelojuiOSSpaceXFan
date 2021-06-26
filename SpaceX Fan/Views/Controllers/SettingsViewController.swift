//
//  SettingsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 26/06/21.
//

import UIKit

class SettingsViewController: UIViewController {
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> SettingsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        return vc
    }
    
    //MARK: - Life cycle
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

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SettingsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as! SettingsTableViewCell
        return cell
    }
}
