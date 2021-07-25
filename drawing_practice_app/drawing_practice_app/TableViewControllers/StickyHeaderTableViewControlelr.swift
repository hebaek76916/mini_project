//
//  StickyHeaderTableViewControlelr.swift
//  drawing_practice_app
//
//  Created by 현은백 on 2021/07/25.
//

import UIKit

class StickyHeaderTableViewControlelr: UIViewController {
    
    var heightConstraint: NSLayoutConstraint!
    
    let baseHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    let segmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        let label = UILabel()
        label.text = "SEGMENT CONTROL VIEW"
        label.sizeToFit()
        view.addSubview(label)
        label.textAlignment = .center
        view.layer.allowsGroupOpacity = true
        return view
    }()
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        let label = UILabel()
        label.text = "ALPHA CONTROL VIEW"
        label.sizeToFit()
        view.addSubview(label)
        label.textAlignment = .center
        view.layer.allowsGroupOpacity = true
        return view
    }()

    
    let maxHeight: CGFloat = 150 // headerView의 최대 높이값
    let minHeight: CGFloat = 60.0 // headerView의 최소 높이값
    
    let tableView: UITableView = {
        let table = UITableView()
        //register cell
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        self.edgesForExtendedLayout = UIRectEdge([])
        
        view.backgroundColor = .systemGray
        
        heightConstraint = baseHeaderView.heightAnchor.constraint(equalToConstant: maxHeight)
        
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(baseHeaderView)
        view.addSubview(tableView)
        
        view.bringSubviewToFront(baseHeaderView)
        
        baseHeaderView.addSubview(segmentView)
        baseHeaderView.addSubview(headerView)
        
        // 첨에 오프셋 주기 ~
        tableView.contentOffset = CGPoint(x: 0, y: -150)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        baseHeaderView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.translatesAutoresizingMaskIntoConstraints = false

        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.contentInsetAdjustmentBehavior = .never
    
        
        
        baseHeaderView.translatesAutoresizingMaskIntoConstraints = false
        baseHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        baseHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        baseHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //baseHeaderView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: baseHeaderView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: baseHeaderView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: baseHeaderView.trailingAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: segmentView.topAnchor).isActive = true
        heightConstraint.isActive = true
        
        
        segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentView.bottomAnchor.constraint(equalTo: baseHeaderView.bottomAnchor).isActive = true
        segmentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }



}
extension StickyHeaderTableViewControlelr: UITableViewDelegate,
                                           UITableViewDataSource {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y < 0 {

            //print("here\(max(abs(scrollView.contentOffset.y), minHeight))")
            heightConstraint.constant = max(abs(scrollView.contentOffset.y), minHeight)
        } else if scrollView.contentOffset.y == -60 {
            heightConstraint.constant = minHeight
        } else {
            heightConstraint.constant = minHeight
        }
    
        let offset = -scrollView.contentOffset.y
        let percentage = (offset-100)/50
        headerView.alpha = percentage

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}
