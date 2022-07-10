//
//  BottomPageVC.swift
//  Sandro Giorgishvili 14
//
//  Created by TBC on 10.07.22.
//

import UIKit

class BottomPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func closePopUp(){
        _ = navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // if user clicks no
    @IBAction func noButtonClick(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // if user clicks yes
    @IBAction func yesButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "log_in_vc") as? LogInPageVC
        guard let logInVc = vc else { return }
        logInVc.modalPresentationStyle = .fullScreen
        self.present(logInVc, animated: true,completion: nil)
    }
}
