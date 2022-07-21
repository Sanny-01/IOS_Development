//
//  ViewController.swift
//  Sandro Giorgishvili 19
//
//  Created by TBC on 21.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var topLabel: UILabel = {
        var topLabel = UILabel()
        view.addSubview(topLabel)
        return topLabel
    }()
    
    lazy var circleView: UIImageView = {
        var circleView = UIImageView()
        view.addSubview(circleView)
        return circleView
    }()
    
    lazy var emailTextField: UITextField = {
        var emailTextField = UITextField()
        view.addSubview(emailTextField)
        return emailTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        var passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        return passwordTextField
    }()
    
    lazy var signInButton: UIButton = {
        var signInButton = UIButton()
        view.addSubview(signInButton)
        return signInButton
    }()
    
    lazy var SignUpButton: UIButton = {
        var SignUpButton = UIButton()
        view.addSubview(SignUpButton)
        return SignUpButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillWithGradient()
        addTopLabel()
        addCircle()
        addEmailTextField()
        addPasswordField()
        addSignInButton()
        addSignUpButton()
    }
    
    func fillWithGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors  = [
            UIColor.systemPurple.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.systemBlue.cgColor
        ]
        
        view.layer.addSublayer(gradientLayer)
    }
    
    
    func addTopLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.textAlignment = .center
        topLabel.textColor = .white
        topLabel.font = topLabel.font.withSize(35)
        view.addSubview(topLabel)
        topLabel.text = "IOS App Templates"
        
        let leftConstraint = NSLayoutConstraint(item: topLabel,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 20).isActive = true

        let rightConstraint = NSLayoutConstraint(item: topLabel,
                                                attribute: .right,
                                                 relatedBy: .equal,
                                                toItem: view,
                                                attribute: .right,
                                                multiplier: 1,
                                                 constant: -20).isActive = true
        
        let top = NSLayoutConstraint(item: topLabel,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: view.safeAreaLayoutGuide,
                                                attribute: .top,
                                                multiplier: 1,
                                     constant: 20).isActive = true
        
        
        let height = NSLayoutConstraint(item: topLabel,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                        constant: 60).isActive = true

    }
    
    func addCircle() {
        let screenWidth = view.frame.width
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .systemIndigo
        circleView.layer.cornerRadius = screenWidth / 3.4
        circleView.layer.borderWidth = 5.0
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.image = UIImage(named:"rocket")
        circleView.clipsToBounds = true
        circleView.contentMode = .scaleAspectFill
        
        let top = NSLayoutConstraint(item: circleView,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: topLabel,
                                                attribute: .bottom,
                                                multiplier: 1,
                                     constant: 50).isActive = true
        
        let width = NSLayoutConstraint(item: circleView,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                       constant: screenWidth / 1.7 ).isActive = true
        
        let aspectRatio = NSLayoutConstraint(item: circleView,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: circleView,
                                             attribute: .width,
                                             multiplier: 1,
                                             constant: 0).isActive = true
    }
    
    func addEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.setLeftPaddingPoints(15)
        emailTextField.layer.cornerRadius = 20
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        
        let leftConstraint = NSLayoutConstraint(item: emailTextField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 20).isActive = true

        let rightConstraint = NSLayoutConstraint(item: emailTextField,
                                                attribute: .right,
                                                 relatedBy: .equal,
                                                toItem: view,
                                                attribute: .right,
                                                multiplier: 1,
                                                 constant: -20).isActive = true
        
        let top = NSLayoutConstraint(item: emailTextField,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: circleView,
                                                attribute: .bottom,
                                                multiplier: 1,
                                     constant: 40).isActive = true
        
        
        let height = NSLayoutConstraint(item: emailTextField,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                        constant: 50).isActive = true

    }
    
    func addPasswordField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.setLeftPaddingPoints(15)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        let leftConstraint = NSLayoutConstraint(item: passwordTextField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 20).isActive = true

        let rightConstraint = NSLayoutConstraint(item: passwordTextField,
                                                attribute: .right,
                                                 relatedBy: .equal,
                                                toItem: view,
                                                attribute: .right,
                                                multiplier: 1,
                                                 constant: -20).isActive = true
        
        let top = NSLayoutConstraint(item: passwordTextField,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: emailTextField,
                                                attribute: .bottom,
                                                multiplier: 1,
                                     constant: 15).isActive = true
        
        
        let height = NSLayoutConstraint(item: passwordTextField,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: emailTextField,
                                       attribute: .height,
                                       multiplier: 1,
                                        constant: 0).isActive = true

    }
    
    func addSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.cornerRadius = 20
        signInButton.backgroundColor = .systemGreen
        signInButton.setTitle("Sing In", for: .normal)
        
        let leftConstraint = NSLayoutConstraint(item: signInButton,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 50).isActive = true

        let rightConstraint = NSLayoutConstraint(item: signInButton,
                                                attribute: .right,
                                                 relatedBy: .equal,
                                                toItem: view,
                                                attribute: .right,
                                                multiplier: 1,
                                                 constant: -50).isActive = true
        
        let top = NSLayoutConstraint(item: signInButton,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: passwordTextField,
                                                attribute: .bottom,
                                                multiplier: 1,
                                     constant: 60).isActive = true
        
        
        let height = NSLayoutConstraint(item: signInButton,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: emailTextField,
                                       attribute: .height,
                                       multiplier: 1,
                                        constant: 0).isActive = true

    }
    
    func addSignUpButton() {
        SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        SignUpButton.layer.cornerRadius = 20
        SignUpButton.setTitleColor(.black, for: .normal)
        SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        SignUpButton.setTitle("Don't have an account? Sign Up", for: .normal)
        
        let leftConstraint = NSLayoutConstraint(item: SignUpButton,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 50).isActive = true

        let rightConstraint = NSLayoutConstraint(item: SignUpButton,
                                                attribute: .right,
                                                 relatedBy: .equal,
                                                toItem: view,
                                                attribute: .right,
                                                multiplier: 1,
                                                 constant: -50).isActive = true
        
        let bottom = NSLayoutConstraint(item: SignUpButton,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .bottom,
                                                multiplier: 1,
                                     constant: -15).isActive = true
        
        
        let height = NSLayoutConstraint(item: SignUpButton,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: emailTextField,
                                       attribute: .height,
                                       multiplier: 1,
                                        constant: 0).isActive = true
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
