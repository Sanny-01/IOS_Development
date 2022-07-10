//
//  DetailsPageVC.swift
//  Sandro Giorgishvili 14
//
//  Created by sgiorgishvili on 09.07.22.
//

import UIKit

class DetailsPageVC: UIViewController {
    
    var username: String?
    var email: String?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
        emailLabel.text = email
    }
    
    // showing bottom page
    @IBAction func signOutButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "bottom_page_vc") as? BottomPageVC
        guard let bottomPageVc = vc else { return }
        bottomPageVc.sheetPresentationController?.detents = [.medium()]
        bottomPageVc.sheetPresentationController?.preferredCornerRadius = 25
        self.present(bottomPageVc, animated: true, completion: nil)
    }
}
