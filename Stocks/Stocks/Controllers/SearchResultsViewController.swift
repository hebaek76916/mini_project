//
//  SearchResultsViewController.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/05.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult)
}

class SearchResultsViewController: UIViewController {

    weak var delegate: SearchResultViewControllerDelegate?
    
    private var results: [SearchResult] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        // Register a cell
        table.register(SearchResultTableViewCell.self,
                       forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTable()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds // Now can know the frame val.
    }
    
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func update(with results: [SearchResult]) {
        self.results = results
        tableView.isHidden = results.isEmpty
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate,
                                       UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.identifier,
            for: indexPath)
        
        let model = results[indexPath.row]
        cell.textLabel?.text = model.displaySymbol
        cell.detailTextLabel?.text = model.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        HapticsManager.shared.vibrateForSelection()
        
        let model = results[indexPath.row]
        delegate?.searchResultsViewControllerDidSelect(searchResult: model)
    }
    
}
