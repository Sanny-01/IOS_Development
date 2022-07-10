//
//  ViewController.swift
//  Sandro Giorgishvili 14
//
//  Created by sgiorgishvili on 09.07.22.
//

import UIKit

class LogInPageVC: UIViewController {
    
    var username: String?
    var email: String?
    var password: String?
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showAlertWithOkButton(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    // moving to sign up page
    @IBAction func pushToViewSignUpPage(_ sender: Any) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "sign_up_VC") as? SignUpVC
                guard let singUpVC = vc else { return }
                self.navigationController?.pushViewController(singUpVC, animated: true)
    }
    
    @IBAction func clickLogInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "details_page_vc") as? DetailsPageVC
        guard let detailsPageVc = vc else { return }
        
        // if there is no user registered
        guard let usernameUnwrp = username else {
            showAlertWithOkButton(message: "No user was registered")
            return
        }
        guard let emailUnwrp = email else {
            showAlertWithOkButton(message: "No user was registered")
            return
        }

        guard let passwordUnwrp = password else {
            showAlertWithOkButton(message: "No user was registered")
            return
        }
        
        // checking if password and username are the same as registered
        if usernameField.text == usernameUnwrp  && passwordField.text == passwordUnwrp {
            detailsPageVc.username = usernameUnwrp
            detailsPageVc.email = emailUnwrp
            self.navigationController?.pushViewController(detailsPageVc, animated: true)
        }
        else {
            showAlertWithOkButton(message: "incorrect credentials")
        }
    }
}
