//
//  SignUpVC.swift
//  Sandro Giorgishvili 14
//
//  Created by sgiorgishvili on 09.07.22.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var repeatPasswordInputField: UITextField!
    @IBOutlet weak var usernameEmptyMessage: UILabel!
    @IBOutlet weak var emailEmptyMessage: UILabel!
    @IBOutlet weak var passwordEmptyMessage: UILabel!
    @IBOutlet weak var repeatPasswordEmptyMessage: UILabel!
    var emptyFields = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showAlertWithOkButton(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    // checking fields if they are empty
    func validateForEmptiness(field: UITextField, errorLabel: UILabel) {
        if field.text == nil || field.text?.count == 0 {
            errorLabel.text = "This field should not be left empty"
            emptyFields += 1
        } else {
            errorLabel.text = ""
        }
    }
    
    // checking password strength using regex
    func validatePasswordStrength(password: String) -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        
        return predicate.evaluate(with: password)
    }

    @IBAction func signUpButtonClick(_ sender: Any) {
        emptyFields = 0
        
        // validating field for emptiness
        validateForEmptiness(field: usernameInputField, errorLabel: usernameEmptyMessage)
        validateForEmptiness(field: emailInputField, errorLabel: emailEmptyMessage)
        validateForEmptiness(field: passwordInputField, errorLabel: passwordEmptyMessage)
        validateForEmptiness(field: repeatPasswordInputField, errorLabel: repeatPasswordEmptyMessage)
        
        // check that all fields are filled (every time user presses sing up button empty fields are equal to 0 we check fields again. if after check it is still 0 then it means they are all filled and we can move on to next validation)
        if emptyFields == 0 {
            
            guard let password = passwordInputField.text else {
                return
            }
            
            if password != repeatPasswordInputField.text {
                showAlertWithOkButton(message: "Passwords do not match")
            }
            else if validatePasswordStrength(password: password ) == false {
                showAlertWithOkButton(message: "This password is not secure")
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "log_in_vc") as? LogInPageVC
                guard let logInPageVc = vc else { return }
                
                guard let username = usernameInputField.text else {
                    return
                }
                guard let email = emailInputField.text else {
                    return
                }
                guard let password = passwordInputField.text else {
                    return
                }
                
                logInPageVc.username = username
                logInPageVc.email = email
                logInPageVc.password = password
            
                self.navigationController?.pushViewController(logInPageVc, animated: true)
            }
        }
    }
}
