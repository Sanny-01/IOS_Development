//
//  ViewController.swift
//  Sandro Giorgishvili 17
//
//  Created by TBC on 19.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redCircle: UIView!
    @IBOutlet weak var blueCircle: UIView!
    @IBOutlet weak var blackTriangle: BlackTriangleVIew!
    @IBOutlet weak var purpleTriangle: PurpleTriangleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        redCircle.makeCircle()
        blueCircle.makeCircle()
        purpleTriangle.backgroundColor = .systemMint
        blackTriangle.backgroundColor = .systemMint
        
        addTap()
    }
    
    func pushToSecondView(fromView: FromWhichView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "second_vc") as? SecondVC
        guard let secondVC = vc else { return }
        secondVC.fromWhichView = fromView
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func addTap() {
        let tapGestureForRedCircle = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
        redCircle.addGestureRecognizer(tapGestureForRedCircle)
        
        let tapGestureForBlueCircle = UITapGestureRecognizer(target: self, action: #selector(blueCircleTapped))
        blueCircle.addGestureRecognizer(tapGestureForBlueCircle)
        
        let tapGestureForPurpleTriangle = UITapGestureRecognizer(target: self, action: #selector(puprleTriangleTapped))
        purpleTriangle.addGestureRecognizer(tapGestureForPurpleTriangle)
        
        let tapGestureForBlackTriangle = UITapGestureRecognizer(target: self, action: #selector(blackTriangleTapped))
        blackTriangle.addGestureRecognizer(tapGestureForBlackTriangle)
        
    }
    
    @objc func redCircleTapped(gesture: UITapGestureRecognizer) {
        pushToSecondView(fromView: .redCircle)
    }
    
    @objc func blueCircleTapped(gesture: UITapGestureRecognizer) {
        pushToSecondView(fromView: .blueCircle)
    }
    
    @objc func puprleTriangleTapped(gesture: UITapGestureRecognizer) {
        pushToSecondView(fromView: .purpleTriangle)
    }
    
    @objc func blackTriangleTapped(gesture: UITapGestureRecognizer) {
        pushToSecondView(fromView: .blackTriangle)
    }
}

extension UIView {
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
    }
}
