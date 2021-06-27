//
//  RocketDetailsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 26/06/21.
//

import UIKit

class RocketDetailsViewController: UIViewController {

    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> RocketDetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RocketDetailsViewController") as! RocketDetailsViewController
        return vc
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    public var viewModel : RocketDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.viewModel == nil {
            self.viewModel = RocketDetailsViewModel()
        }
        self.viewModel?.setDelegate(self)
        self.favoriteButton.isSelected = self.viewModel!.isFavourited
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseAnalytics.logScreen(name: FirebaseAnalytics.ScreenNames.RocketDetails)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        _ =  UIApplication.topViewController()?.checkIsUserAuthorized({ (_ autherizedUser) in
            if autherizedUser == true {
                self.viewModel?.favoriteRocket()
            }
        })
    }
}

//MARK: - RocketDetailsProtocal
extension RocketDetailsViewController : RocketDetailsProtocal {
    func favoriteStatusUpdated() {
        DispatchQueue.main.async {
            self.favoriteButton.isSelected = self.viewModel!.isFavourited
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension RocketDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + (self.viewModel?.linksList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsVCHeaderTableViewCell") as! DetailsVCHeaderTableViewCell
            cell.rocketResponse = self.viewModel?.rocketResponse
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsVCFlightDetailsTableViewCell") as! DetailsVCFlightDetailsTableViewCell
            cell.rocketResponse = self.viewModel?.rocketResponse
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsVCDetailsTableViewCell") as! DetailsVCDetailsTableViewCell
            cell.rocketResponse = self.viewModel?.rocketResponse
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsVCInternalLinksTableViewCell") as! DetailsVCInternalLinksTableViewCell
            guard let object = self.viewModel?.linksList?[indexPath.row - 3] else { return cell }
            cell.webLinkObject = object
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let count = self.viewModel?.rocketResponse?.links?.flickr?.original?.count ?? 0
            return count > 0 ? Constants.Bounds.width : 150
        } else {
            return UITableView.automaticDimension
        }
    }
    
}

extension RocketDetailsViewController : DetailsVCHeaderTableViewDelegate {
    func imagePressed(index: Int, imagesList: [String]) {
        DispatchQueue.main.async {
            let viewController = PreviewViewController.create()
            let vm = PreviewImageViewModel()
            vm.imagesList = imagesList
            vm.selectedIndex = index
            viewController.viewModel = vm
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
