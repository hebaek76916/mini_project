//
//  ButtonAnimationViewController.swift
//  drawing_practice_app
//
//  Created by 현은백 on 2021/05/23.
//

import UIKit

class ButtonAnimationViewController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.init(red: 48/255, green: 155/255, blue: 255/255, alpha: 1)
        button.setTitle("Am I Animating?", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
        button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
    }
    

    @objc fileprivate func buttonSelected(_ sender: UIButton){
        print("select")
        animateView(sender)
    }
    fileprivate func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseIn,
                       animations: {
                        viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
                       }) { (_) in
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseIn,
                           animations: {
                            viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                           }, completion: nil)
        }
    }

}
