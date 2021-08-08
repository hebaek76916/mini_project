//
//  MyAlert.swift
//  mini_skills
//
//  Created by 현은백 on 2021/08/08.
//

import UIKit

class MyAlert {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgrounView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.alpha = 1
        return view
    }()
    
    private var myTargetView: UIView?
    
    func showAlert(with title: String,
                   message: String,
                   on viewController: UIViewController) {
        guard
            let targetView = viewController.view
            else { return }
        
        myTargetView = targetView
        
//        myTargetView?.translatesAutoresizingMaskIntoConstraints = false
//        targetView.translatesAutoresizingMaskIntoConstraints = false
//        backgrounView.translatesAutoresizingMaskIntoConstraints = false
//        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        backgrounView.frame = targetView.bounds
        
        
        targetView.addSubview(backgrounView)
        
        targetView.addSubview(alertView)
        
        alertView.isUserInteractionEnabled = true
        
        alertView.frame = CGRect(x: 40, y: -300,
                                 width: targetView.frame.size.width - 80,
                                 height: 300)
        //alertView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor)
        
        
        
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 80,
                                               width: alertView.frame.size.width,
                                               height: 170))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height - 50,
                                            width: alertView.frame.size.width,
                                            height: 50))
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        
                        self.backgrounView.alpha = Constants.backgroundAlphaTo
                        
                       }, completion: { done in
                        
                        if done {
                            UIView.animate(withDuration: 0.25,
                                           animations: {
                                            self.alertView.center = targetView.center
                                           })
                        }
                        
                       }
        )
        
    }
    
    @objc func dismissAlert() {
        guard  let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.alertView.frame = CGRect(x: 40,
                                                      y: targetView.frame.size.height,
                                                      width: targetView.frame.size.width - 80,
                                                      height: 300)
                       }, completion: { done in
                        if done {
                            UIView.animate(withDuration: 0.25,
                                           animations: {
                                            self.backgrounView.alpha = 0
                                           }, completion: { done in
                                            if done {
                                                self.alertView.removeFromSuperview()
                                                self.backgrounView.removeFromSuperview()
                                            }
                                           })
                        }
                        
                       })
    }
}


class MyAlert_AutoLayout {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgrounView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var myTargetView: UIView?
    
    func showAlert(with title: String,
                   message: String,
                   on viewController: UIViewController) {
        guard
            let targetView = viewController.view
            else { return }
        
        myTargetView = targetView
        
        myTargetView!.translatesAutoresizingMaskIntoConstraints = false
        targetView.translatesAutoresizingMaskIntoConstraints = false

        
        
        
        backgrounView.frame = targetView.bounds
        
        
        targetView.addSubview(backgrounView)
        
        targetView.addSubview(alertView)
        
        alertView.isUserInteractionEnabled = true
        
//        alertView.frame = CGRect(x: 40, y: -300,
//                                 width: targetView.frame.size.width - 80,
//                                 height: 300)
        alertView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: 40).isActive = true
        //alertView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -40).isActive = true
        alertView.widthAnchor.constraint(equalToConstant: targetView.frame.size.width - 80).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        alertView.topAnchor.constraint(equalTo: targetView.topAnchor, constant: -300).isActive = true
        
        
        
        
        
        //let titleLabel = UILabel()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        //titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        let messageLabel = UILabel()//(frame: CGRect(x: 0, y: 80,
                                  //             width: alertView.frame.size.width,
                                  //          height: 170))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        alertView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        
        
        let button = UIButton()//frame: CGRect(x: 0,
                              //              y: alertView.frame.size.height - 50,
                              //              width: alertView.frame.size.width,
                              //              height: 50))
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        
                        self.backgrounView.alpha = Constants.backgroundAlphaTo
                        
                       }, completion: { done in
                        
                        if done {
                            UIView.animate(withDuration: 0.25,
                                           animations: {
                                            self.alertView.center = targetView.center
                                            
                                          
                                           })
                        }
                        
                       }
        )
        
    }
    
    @objc func dismissAlert() {
        guard  let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.alertView.frame = CGRect(x: 40,
                                                      y: targetView.frame.size.height,
                                                      width: targetView.frame.size.width - 80,
                                                      height: 300)
                       }, completion: { done in
                        if done {
                            UIView.animate(withDuration: 0.25,
                                           animations: {
                                            self.backgrounView.alpha = 0
                                           }, completion: { done in
                                            if done {
                                                self.alertView.removeFromSuperview()
                                                self.backgrounView.removeFromSuperview()
                                            }
                                           })
                        }
                        
                       })
    }
}
