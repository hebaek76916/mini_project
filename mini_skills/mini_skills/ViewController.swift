//
//  ViewController.swift
//  mini_skills
//
//  Created by 현은백 on 2021/07/01.
//

import UIKit
class Components {
    
    let components = [(name: "Fade out Animation", vc: FadeOutViewController()),
                      (name: "Custom Alert View", vc: UIViewController())
    ]
}



class ViewController: UIViewController {

    let components = Components().components
    let customAlert = MyAlert_AutoLayout()//MyAlert()
    
    let table = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SKILL List"
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
    }

}
extension ViewController: UITableViewDelegate,
                          UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = components[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 1 {
            print("ALERT SELECT")
            customAlert.showAlert(with: "HELLO WORLD",
                                  message: "미미미미\n아 밥을많이 먹었다\n배불러 죽겠다",
                                  on: self)
        } else {
            print("MOVE TO OTHER VC")
            navigationController?.pushViewController(components[indexPath.row].vc, animated: true)
        }
        
    }
    
    
}



