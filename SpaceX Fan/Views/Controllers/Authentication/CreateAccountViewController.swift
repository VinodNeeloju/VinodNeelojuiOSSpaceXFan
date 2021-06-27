//
//  CreateAccountViewController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 25/06/21.
//

import UIKit

class CreateAccountViewController: UIViewController {

    /// create() will create the instace of the class and returns the storyboard instance of the class.
    static func create() -> CreateAccountViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        vc.modalPresentationStyle = .custom
        return vc
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var viewModel : SignInViewModel?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = SignInViewModel.init(with: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseAnalytics.logScreen(name: FirebaseAnalytics.ScreenNames.CreateAccount)
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
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        self.viewModel?.createAccount(with: self.nameTextField.text, email: self.emailTextField.text, password: self.passwordTextField.text, confirmPassword: self.confirmPasswordTextField.text)
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        Constants.KeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}

//MARK: - SignInViewController
extension CreateAccountViewController : SignInProtocal {
    func requestingServer() {
        ///Show loader to block the ui after getting the success response or failure response dismiss the Loader...
        Constants.Loader.showLoader()
        FirebaseAnalytics.logEvent(event: FirebaseAnalytics.EventName.CreateAccount)
    }
    
    func gotTheSuccessResponse() {
        //SignIn successfull close the signin screen and go to the home screen
        Constants.KeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func requestFailed(with reason: String?, failed field: Int) {
        switch field {
        case 1:
            nameTextField.shake()
        case 2:
            emailTextField.shake()
        case 3:
            passwordTextField.shake()
        case 4:
            confirmPasswordTextField.shake()
        default:
            ///Dismissing the loader... The loader already presented on the api request
            Constants.Loader.dismissLoader(completion: nil)
            break
        }
        Constants.KeyWindow?.makeToast(reason ?? "Something went wrong please try again")
    }
    
    
}
