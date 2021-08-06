//
//  TableViewController.swift
//  presento
//
//  Created by 현은백 on 2021/08/05.
//

import UIKit

class TableViewController: UIViewController {

    let tableTitle: [String] = ["HEE JUNG ✉️",
    "HYEUN EUN 🦚",
    "GUESS WHO? 🔵"]
    
    let letters = ["""
                        으니야~~생일 많이 많이 축하해:)
                        한결 같은 우리 보니까 기분이 좋넹ㅋㅋㅋ항상 고맙고 항상 응원해! 너가 하고 있는 너의 길이 행복해보여서 보기 좋아~ 우리의 30살이 기대된다 그때면 또 많이 달라져있겠지? 앞으로도 지금처럼만 꾸준히 오래보며 건강하자 알라븅😎
                    """,
                   """
        내편지
        dㅁㄴㅇㄹ
        dㅁㄴㅇㄹ
        dㅁㄴㅇㄹ
        dㅁㄴㅇㄹ

        """,
                   """
                        은희야 안녕 ~! 나 중학교 때 만난 현진이야 ㅎㅎ 생일축하해 😊😊
                        나 기억하니 ?! 인스타로 가끔씩 일상을 구경했었는데 아주 잘 살고 있는것 같아 ~~~ 멋져 👍
                        나는 현은이와 함께 일하며 지내고 있어 !! (+ 피아노 연주도 함께)
                        이런 멋진 선물을 준비하는 현은이는 정말 좋은 친구인 것 같아 🍀 은희 너가 좋은 사람이라는 의미겠지??! 친구는 끼리끼리 매-직 이니까 ♥️
                        그럼 오늘 재밌게 놀아! 안녕!
        """
    ]
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //Register Cell
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Letters ✉️"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

    
}

extension TableViewController: UITableViewDelegate,
                               UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.textAlignment = .center
        cell.textLabel!.text = "\(tableTitle[indexPath.row])"
        cell.textLabel!.font = UIFont(name: "AmericanTypewriter-Bold" , size: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ActivationRequiredViewController()
        vc.configure(letter: letters[indexPath.row], image: "hj")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
