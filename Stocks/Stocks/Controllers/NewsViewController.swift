//
//  TopStoriesNewsViewController.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/05.
//

import UIKit

class NewsViewController: UIViewController {

    enum `Type` {
        case topStories
        case compan(symbol: String)
        
        var title: String {
            switch self {
            case .topStories:
                return "Top Stories"
            case .compan(let symbol):
                return symbol.uppercased()
            }
        }
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        //Register cell, header
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        return table
    }()
    
    // MARK: - Properties
    
    private var stories = [String]()
    
    private let type: Type
    
    // MARK: - initializer
    
    init(type: Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        fetchNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Privates
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchNews() {
        
    }
    
    private func open(url: URL) {
        
    }

}

extension NewsViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: NewsHeaderView.identifier
        ) as? NewsHeaderView else {
            return nil
        }
        header.configure(with: .init(
                            title: self.type.title,
                            shouldShowAddButton: true))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.preferredHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
