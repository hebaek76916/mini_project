//
//  dVC.swift
//  PhotoCollection_practice
//
//  Created by 현은백 on 2021/02/16.
//

import UIKit

class dVC: UIViewController {

    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "Before Alert"
        return label
    }()
    
    let presentPopUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2132163644, green: 0.9210149646, blue: 0.6173293591, alpha: 1)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.text = "present modal!"
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupView()
    
    }
    
    @objc func presentPopupButtonHandler() {
        print ("눌렸어")
        let vc = CustomPopUp()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    func setupView() {
        view.addSubview(checkLabel)
        view.addSubview(presentPopUpButton)
        
        checkLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(self.view)
        }
        
        presentPopUpButton.snp.makeConstraints{ make in
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.top.equalTo(self.view).offset(300)
        }
        
        presentPopUpButton.addTarget(self, action: #selector(presentPopupButtonHandler), for: .touchUpInside)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension dVC: CustomPopUpDelegate {
    func pressOkButton() {
        let alert = UIAlertController(title: "ALERT ", message: "THIS IS ALERT",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok",
                                     style: .default) { _ in
            DispatchQueue.main.async { [weak self] in
                self?.checkLabel.text = "AFTER ALERT"
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
            
        }
    }
}
