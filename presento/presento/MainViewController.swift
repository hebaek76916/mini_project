//
//  MainViewController.swift
//  presento
//
//  Created by 현은백 on 2021/08/05.
//

import UIKit
import ConfettiView

class MainViewController: UIViewController {

    
    let confettiView = ConfettiView()
    
    let letterButton: UIButton = {
        let button = UIButton()
        button.setTitle("🕊 Letter Arrived!  ✉️ \n Click Here!", for: .normal)
        button.titleLabel!.font = UIFont(name: "AmericanTypewriter-Bold" , size: 32) ?? UIFont.italicSystemFont(ofSize: 20)
        button.titleLabel!.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.alpha = 0
        button.titleLabel!.doGlowAnimation(withColor: UIColor.yellow)
        //button.layer.borderWidth = 3
        //button.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        return button
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Press", for: .normal)
        button.titleLabel!.font = UIFont(name: "AmericanTypewriter-Bold" , size: 25) ?? UIFont.italicSystemFont(ofSize: 25)
        
        button.titleLabel!.textColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.alpha = 0
        button.layer.cornerRadius = 34
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        imageView.alpha = 0

        return imageView
    }()
    
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Happy\nBirthday\nSweetie ♥︎"
        label.font = UIFont(name: "AmericanTypewriter-Bold" , size: 30) ?? UIFont.italicSystemFont(ofSize: 30)
        //label.font = UIFont.italicSystemFont(ofSize: 20)
        label.alpha = 0
        label.numberOfLines = 0
        label.textColor = .white
        
        label.textAlignment = .center
        return label
        
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .black
        
        view.addSubview(confettiView)
        view.addSubview(imageView)
        imageView.addSubview(label)
        view.addSubview(letterButton)

        
        view.addSubview(button)
        // Do any additional setup after loading the view.
        button.addTarget(self, action: #selector(presentView(_:)), for: .touchUpInside)
        letterButton.addTarget(self, action: #selector(letterTableViewController(_:)), for: .touchUpInside)
        
        
        confettiView.emit(with: [
            .text("💜"),
            .text("🎆"),
            .text("🎨"),
            .shape(.circle, #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
            .shape(.triangle, #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        ],
        for: 1) { _ in
            UIView.animate(withDuration: 3) {
                self.imageView.alpha = 1.0
                self.button.alpha = 1.0
                self.label.alpha = 1.0
            }
            
        }
    }
    
    let img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "e1")
        imageView.systemLayoutSizeFitting(CGSize(width: 30, height: 30))// = CGSize(width: 30.0, height: 30.0)
        return imageView
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //confettiView.translatesAutoresizingMaskIntoConstraints = false
        confettiView.frame = view.bounds
        imageView.frame = view.bounds
        
        label.sizeToFit()
        label.center = imageView.center
        
        button.frame = CGRect(x: (view.frame.width / 4),
                              y: (view.frame.height/2.8) * 2 ,
                                 width: (view.frame.width / 2),
                                 height: 65)
        letterButton.frame = CGRect(x: 16,
                                    y: (view.frame.height/5),
                                    width: (view.frame.width - 32),
                                    height: 60)
    }

    @objc func presentView(_ sender: UIButton) {
        let vc = ViewController()
        present(vc, animated: true) {
            self.letterButton.alpha = 1
            
        }
        //letterButton.alpha = 1
        
    }

    
    @objc func letterTableViewController(_ sender: UIButton) {
        let vc = TableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
