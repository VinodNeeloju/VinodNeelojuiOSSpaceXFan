//
//  SpaceXRocketsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class SpaceXRocketsViewController: UIViewController {
    
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> SpaceXRocketsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpaceXRocketsViewController") as! SpaceXRocketsViewController
        return vc
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : SpaceXRocketsViewModel?
    
    // MARK: - Override Methodes
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//        } else {
//            // Fallback on earlier versions
//        }
        self.tableView.register(UINib.init(nibName: String(describing: RocketInfoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RocketInfoTableViewCell.self))
        viewModel = SpaceXRocketsViewModel.init(with: self)
        viewModel?.fetchRocketsList()
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

// MARK: - SpaceXRocketsProtocal
extension SpaceXRocketsViewController : SpaceXRocketsProtocal {
    func gotTheResponse() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func requestFailed(with reason: String?) {
        print(reason ?? "")
        if reason != nil {
            Constants.KeyWindow?.makeToast(reason!)
        }
    }
}
 
// MARK: - UITableViewDataSource, UITableViewDelegate
extension SpaceXRocketsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel?.rocketsList?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RocketInfoTableViewCell.self)) as! RocketInfoTableViewCell
        guard let rocketResponse = self.viewModel?.rocketsList?[indexPath.row] else { return cell }
        cell.rocketResponse = rocketResponse
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

