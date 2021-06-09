//
//  customPopup.swift
//  PhotoCollection_practice
//
//  Created by 현은백 on 2021/02/16.
//

import Foundation
import SnapKit

protocol CustomPopUpDelegate: class {
    func pressOkButton()
}

class CustomPopUp: UIViewController {
    
    // MARK : View Component
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.titleLabel?.text = "cancel"
        return button
    }()
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("ok", for: .normal)
        button.titleLabel?.text = "ok"
        return button
    }()
    
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    // MARK : Properties
    weak var delegate: CustomPopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.alpha = 0.6
        configure()
        
    }
    
    // MARK : Selector
    @objc func cancelButtonHandler() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonHandler() {
        delegate?.pressOkButton()
        dismiss(animated: true, completion: nil)
    }
    
    func configure() {
        view.addSubview(popupView)
        popupView.snp.makeConstraints{ (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(200)
            make.width.equalTo(300)
        }
        
        popupView.addSubview(cancelButton)
        popupView.addSubview(okButton)
        cancelButton.snp.makeConstraints{ (make) in
            make.leading.equalTo(self.popupView)
            make.bottom.equalTo(self.popupView)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        okButton.snp.makeConstraints{ (make) in
            make.trailing.equalTo(self.popupView)
            make.bottom.equalTo(self.popupView)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        cancelButton.addTarget(self, action: #selector(cancelButtonHandler), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonHandler), for: .touchUpInside)
    }
}
