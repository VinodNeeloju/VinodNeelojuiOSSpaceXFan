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
        self.tableView.register(UINib.init(nibName: String(describing: RocketInfoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RocketInfoTableViewCell.self))
        viewModel = SpaceXRocketsViewModel.init(with: self)
        Constants.Loader.showLoader()
        viewModel?.fetchRocketsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        Constants.Loader.dismissLoader {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if self.viewModel?.rocketsList?.count ?? 0 == 0 {
                Constants.KeyWindow?.makeToast("Rockets list is empty")
            }
        }
    }
    
    func requestFailed(with reason: String?) {
        Constants.Loader.dismissLoader {
            print(reason ?? "")
            if reason != nil {
                Constants.KeyWindow?.makeToast(reason!)
            }
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard let rocketResponse = self.viewModel?.rocketsList?[indexPath.row] else { return }
            let viewController = RocketDetailsViewController.create()
            let vm = RocketDetailsViewModel()
            vm.rocketResponse = rocketResponse
            viewController.viewModel = vm
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

//MARK: - RocketInfoTableViewCellDelegate
extension SpaceXRocketsViewController : RocketInfoTableViewCellDelegate{
    func bookmarkAction(with rocketResponse: RocketResponse, sender: UIButton) {
        _ =  UIApplication.topViewController()?.checkIsUserAuthorized({ (_ autherizedUser) in
            if autherizedUser == true {
                let flag = sender.isSelected
                DispatchQueue.main.async {
                    sender.isSelected = !sender.isSelected
                }
                guard let uid = FirebaseAuthenticationManager.shared.user?.uid else { return }
                guard let id = rocketResponse.id else { return }
                if flag == false {
                    FirebaseStoreManager.shared.addBookmark(with: uid, bookmarkId: id)
                } else {
                    FirebaseStoreManager.shared.removeBookmark(with: uid, bookmarkId: id)
                }
            }
        })
    }
}
