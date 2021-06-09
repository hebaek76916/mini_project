//
//  ViewController.swift
//  toy_weather
//
//  Created by 현은백 on 2021/02/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let table: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        table.register(HorizontalCollectionTableCell.self, forCellReuseIdentifier: HorizontalCollectionTableCell.identifier)
        table.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(table)
        table.backgroundColor = .clear
        table.snp.makeConstraints{ (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
        }
    }


}

extension ViewController: UITableViewDelegate {
    
}
extension ViewController : UITableViewDataSource {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let scrollHeaderHeight = table.sectionHeaderHeight
//        print("case 0 : \(scrollHeaderHeight)")
//
//        if scrollView.contentOffset.y <= scrollHeaderHeight {
//            print("case 1 : \(scrollView.contentOffset.y)")
//            if scrollView.contentOffset.y >= 0 {
//                print("case 2 : \(scrollView.contentOffset.y)")
//                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
//            }
//        } else if (scrollView.contentOffset.y >= scrollHeaderHeight) {
//            print("case 3 : \(scrollView.contentOffset.y)")
//            scrollView.contentInset = UIEdgeInsets(top: -scrollHeaderHeight, left: 0, bottom: 0, right: 0)
//        }
//
    }
//indexPath 0 : Height 200
//else 80
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: HorizontalCollectionTableCell.identifier) as? HorizontalCollectionTableCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier) as? WeatherCell)!
            cell.backgroundColor = .clear
        
            cell.dayLabel.text = "Hi"
        
            return cell
            
        }
    }
}

//extension Reu
