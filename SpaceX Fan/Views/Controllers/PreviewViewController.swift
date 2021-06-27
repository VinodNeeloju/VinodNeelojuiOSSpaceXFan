//
//  PreviewViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class PreviewViewController: UIViewController {
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> PreviewViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        return vc
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var viewModel : PreviewImageViewModel?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if viewModel?.imagesList == nil {
            Constants.KeyWindow?.makeToast("Facing issue with image. Please select the other image")
            self.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        if let index = self.viewModel?.selectedIndex, index != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
       
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseAnalytics.logScreen(name: FirebaseAnalytics.ScreenNames.ImagePreview)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeButtonAction(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

//MAK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PreviewViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = self.viewModel?.imagesList?.count else { return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewImageCollectionViewCell", for: indexPath) as! PreviewImageCollectionViewCell
        guard let imageString = self.viewModel?.imagesList?[indexPath.row] else { return cell }
        cell.imageString = imageString
        return cell
    }
    
    
}

//MAR: - UICollectionViewDelegateFlowLayout
extension PreviewViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 1)
    }
}
