//
//  AuthenticateOptionsViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit

class AuthenticateOptionsViewController: UIViewController {
    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> AuthenticateOptionsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthenticateOptionsViewController") as! AuthenticateOptionsViewController
        vc.modalPresentationStyle = .custom
        return vc
    }
    //MARK: IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateBackgroundView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: IBActions
    @IBAction func signInButtonAction(_ sender: UIButton) {
        self.present(SignInViewController.create(), animated: true, completion: nil)
    }
    @IBAction func createAccountButtonAction(_ sender: UIButton) {
        self.present(CreateAccountViewController.create(), animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.removeAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}


extension AuthenticateOptionsViewController {
    ///Animating the background view with spring effect and showing the popup
    func animateBackgroundView()
    {
        DispatchQueue.main.async {
            self.backgroundView.isHidden = false
            self.backgroundView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
             UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
               self.backgroundView.transform = .identity
             })
        }
    }
    
    ///Animating the background view with spring effect with removing effect
    func removeAnimation() {
        DispatchQueue.main.async {
            self.backgroundView.transform = .identity
             UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                self.backgroundView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
             })
        }
    }
    
}
