//
//  ViewController.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/05.
//

import UIKit

class WatchListViewController: UIViewController {

    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
        setUpTitleView()
    }
    
    // MARK: - Private
    
    private func setUpTitleView() {
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: navigationController?.navigationBar.height ?? 100))
        
        let label = UILabel(frame: CGRect(x: 10, y: 0,
                                          width: titleView.width-20, height: titleView.height))
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        titleView.addSubview(label)
        
        navigationItem.titleView = titleView
    }
    
    private func setUpSearchController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }

}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text,//search bar의 text가 있고
              let resultVC = searchController.searchResultsController as? SearchResultsViewController,//유남쌩?
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {//query의 white space를 자른게 nil이 아니라면
            
            return
        
        }
        
        // Reset timer
        searchTimer?.invalidate()
        
        // Kick off new timer
        // Optimaize to reduce number of searches for when user stops typing.
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false,
                                           block: { _ in
                                            // Call API to search
                                            APICaller.shared.search(query: query) { result in
                                                switch result {
                                                case .success(let response):
                                                    DispatchQueue.main.async {
                                                        resultVC.update(with: response.result)
                                                    }
                                                case .failure(let error):
                                                    print(error)
                                                }
                                            }
                                           })
//        // Call API to search
//        APICaller.shared.search(query: query) { result in
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    resultVC.update(with: response.result)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        // Update results controller
        
    }
    
    
}

extension WatchListViewController: SearchResultViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        // Present stock details for given selection
        print("Did select \(searchResult.displaySymbol)")
    }
    
    
}
