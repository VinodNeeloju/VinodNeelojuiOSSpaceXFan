//
//  LoadingViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class LoadingViewController: UIViewController {

    static func create() -> LoadingViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        vc.modalPresentationStyle = .custom
        return vc
    }
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    private var isShowing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.indicatorView.startAnimating()
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


extension LoadingViewController {
    func showLoader() {
        if isShowing { return }
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(self, animated: false, completion: {
                self.isShowing = true
            })
        }
    }
    
    func dismissLoader(completion: (() -> ())?) {
        if !isShowing { return }
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: { [weak self] in
                self?.isShowing = false
                completion?()
            })
        }
    }
}
