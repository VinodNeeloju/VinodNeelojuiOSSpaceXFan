//
//  SignInViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit

class SignInViewController: UIViewController {

    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> SignInViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        vc.modalPresentationStyle = .custom
        return vc
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel : SignInViewModel?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = SignInViewModel.init(with: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - IBAction
    @IBAction func signInButtonAction(_ sender: UIButton) {
        self.viewModel?.signInUser(with: self.emailTextField.text, and: self.passwordTextField.text)
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        Constants.KeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}

//MARK: - SignInViewController
extension SignInViewController : SignInProtocal {
    func gotTheSuccessResponse() {
        //SignIn successfull close the signin screen and go to the home screen
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestFailed(with reason: String?, failed field: Int) {
        switch field {
        case 1:
            emailTextField.shake()
        case 2:
            passwordTextField.shake()
        default:
            break
        }
        Constants.KeyWindow?.makeToast(reason ?? "Something went wrong please try again")
    }
    
    
}
