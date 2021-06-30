//
//  FadeOutViewController.swift
//  mini_skills
//
//  Created by 현은백 on 2021/07/01.
//

import UIKit

class FadeOutViewController: UIViewController {

    let fadingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .purple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fadingView)
        fadingView.frame = CGRect(x: (view.frame.width - 100)/2, y: (view.frame.height - 60)/2, width: 100, height: 60)
        view.backgroundColor = .systemBackground
        
        fadeViewInThenOut(view: fadingView, delay: 0)
    }
    
    func fadeViewInThenOut(view: UIView, delay: TimeInterval) {
        let animationDuration = 1.5
        
        UIView.animate(withDuration: animationDuration,
                       delay: delay,
                       options: [UIView.AnimationOptions.autoreverse,
                                 UIView.AnimationOptions.repeat],
                       animations: {
                        view.alpha = 0
                       },
                       completion: nil)
    }

}
