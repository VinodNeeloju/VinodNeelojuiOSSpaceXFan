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
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : FavoriteRocketsViewModel?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: String(describing: RocketInfoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RocketInfoTableViewCell.self))
        viewModel = FavoriteRocketsViewModel.init(with: self)
        self.tableView.refreshControl = PullToRefreshController.init(with: self, title: "Refreshing your favorites")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseAnalytics.logScreen(name: FirebaseAnalytics.ScreenNames.FavoriteRockets)
        viewModel?.fetchAllFavoriteRocketsList()
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
//MARK: - FavouriteRocketsProtocal
extension FavoriteRocketsViewController : FavouriteRocketsProtocal {
    func gotTheResponse() {
        self.tableView.refreshControl?.endRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if self.viewModel?.favouritesList?.count ?? 0 == 0 {
            Constants.KeyWindow?.makeToast("Your favorite list is empty")
        }
    }
    
    func requestFailed(with reason: String?) {
        self.tableView.refreshControl?.endRefreshing()
        Constants.KeyWindow?.makeToast(reason ?? "Something went wrong")
    }

}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoriteRocketsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.favouritesList?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RocketInfoTableViewCell.self)) as! RocketInfoTableViewCell
        guard let rocketResponse = self.viewModel?.favouritesList?[indexPath.row] else { return cell }
        cell.rocketResponse = rocketResponse
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showUnfavoriteConfirmationPopup(with: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard let rocketResponse = self.viewModel?.favouritesList?[indexPath.row] else { return }
            let viewController = RocketDetailsViewController.create()
            let vm = RocketDetailsViewModel()
            vm.rocketResponse = rocketResponse
            viewController.viewModel = vm
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
}


//MARK: - RocketInfoTableViewCellDelegate
extension FavoriteRocketsViewController : RocketInfoTableViewCellDelegate{
    func bookmarkAction(with rocketResponse: RocketResponse, sender: UIButton) {
        if let index = self.viewModel?.indexOfObject(rocketResponse) {
            self.tableView(self.tableView, commit: .delete, forRowAt: IndexPath(row: index, section: 0))
        }
    }
}

extension FavoriteRocketsViewController  {
    
    ///This method is to show the conformation popup to remove favorite from the list
    private func showUnfavoriteConfirmationPopup(with indexPath : IndexPath) {
        guard FirebaseAuthenticationManager.shared.isUserExist == true else { return }
        guard let name = self.viewModel?.favouritesList?[indexPath.row].name else { return }
        let alertController = UIAlertController.init(title: "Unfavorite?", message: "Are you sure do you want to remove '\(name)' from favorites list?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_ alert) in
            self.viewModel?.removeRocketFromFavoriteList(with: indexPath) {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
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
}


extension FavoriteRocketsViewController : PulltoRefreshProtocal {
    func refreshStatrted(refreshController: UIRefreshControl) {
        self.viewModel?.fetchAllFavoriteRocketsList()
    }
}
