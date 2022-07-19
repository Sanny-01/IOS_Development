//
//  SecondVC.swift
//  Sandro Giorgishvili 17
//
//  Created by TBC on 19.07.22.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var fromWhichView: FromWhichView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch fromWhichView {
        case .redCircle:
            print("From red circle")
            addLongPress()
            addTap()
        case .blueCircle:
            print("From blue circle")
            addLongPress()
        case .purpleTriangle:
            print("From purple triangle")
            addSwipe()
        case .blackTriangle:
            print("From black triangle")
            addPinch()
        default:
            print("Error")
        }
        
        let gif = UIImage.gifImageWithName("matrix1")
        image.image = gif
    }
    
    func addLongPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGesture.minimumPressDuration = 1
        image.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        switch fromWhichView {
        case .blueCircle:
            image.isHidden = true
        default:
            print("Error ocurred")
        }
    }
    
    // იმ შემთხვევაში თუ იმიჯს 1 წამზე ნაკლებ დროის განმავლობაში დააჭერს იუზერი
    func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(gesture: UITapGestureRecognizer) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addSwipe() {
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedOnView))
        rightSwipeGesture.direction = .right
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedOnView))
        leftSwipeGesture.direction = .left
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedOnView))
        upSwipeGesture.direction = .up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedOnView))
        downSwipeGesture.direction = .down
        
        image.addGestureRecognizer(rightSwipeGesture)
        image.addGestureRecognizer(leftSwipeGesture)
        image.addGestureRecognizer(upSwipeGesture)
        image.addGestureRecognizer(downSwipeGesture)
    }
    
    @objc func swipedOnView(gesture: UISwipeGestureRecognizer) {
        let frm: CGRect = image.frame
        
        switch gesture.direction {
        case .left:
            print("left")
            image.frame = CGRect(x: frm.origin.x - 50, y: frm.origin.y, width: 300, height: 300)
        case .right:
            print("right")
            image.frame = CGRect(x: frm.origin.x + 50, y: frm.origin.y, width: 300, height: 300)
        case .up:
            print("up")
            image.frame = CGRect(x: frm.origin.x, y: frm.origin.y + 50, width: 300, height: 300)
        case .down:
            print("down")
            image.frame = CGRect(x: frm.origin.x, y: frm.origin.y - 50, width: 300, height: 300)
        default:
            print("other")
        }
    }
    
    func addPinch() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        image.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinched(gesture: UIPinchGestureRecognizer) {
        gesture.view?.transform = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale))!
        gesture.scale = 1.0
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        
        if image.frame.height > safeAreaHeight {
            NotificationCenter.default.post(name: Notification.Name("com.TBCLecture.Notification.colorChange"), object: nil, userInfo: nil)
            image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            image.center = self.view.center
        }
    }
}
