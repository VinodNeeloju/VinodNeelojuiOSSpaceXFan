//
//  FavoriteRocketsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 23/06/21.
//

import UIKit

class FavoriteRocketsViewController: UIViewController {

    /// create() will create the instace of the class and returns the storyboard instance of the class.
    
    @IBOutlet weak var tableView: UITableView!
    
    static func create() -> FavoriteRocketsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteRocketsViewController") as! FavoriteRocketsViewController
        return vc
    }
    
    private var viewModel : FavoriteRocketsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: String(describing: RocketInfoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RocketInfoTableViewCell.self))
        viewModel = FavoriteRocketsViewModel.init(with: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAllFavoriteRocketsList()
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func requestFailed(with reason: String?) {
        
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
            self.viewModel?.removeRocketFromFavoriteList(with: indexPath) {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
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
}


//MARK: - RocketInfoTableViewCellDelegate
extension FavoriteRocketsViewController : RocketInfoTableViewCellDelegate{
    func bookmarkAction(with rocketResponse: RocketResponse, sender: UIButton) {
        if let index = self.viewModel?.indexOfObject(rocketResponse) {
            self.tableView(self.tableView, commit: .delete, forRowAt: IndexPath(row: index, section: 0))
        }
    }
}

