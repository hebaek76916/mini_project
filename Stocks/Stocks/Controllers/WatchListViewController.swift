//
//  ViewController.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/05.
//

import UIKit
import FloatingPanel

class WatchListViewController: UIViewController {

    private var searchTimer: Timer?
    
    private var panel: FloatingPanelController?
    
    static var maxChangeWidth: CGFloat = 0
    
    // Model
    private var watchlistMap: [String: [CandleStick]] = [:]
    
    // ViewModel
    private var viewModels: [WatchListTableViewCell.ViewModel] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WatchListTableViewCell.self,
                           forCellReuseIdentifier: WatchListTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
        setUpTableView()
        fetchWatchlistData()
        
        setUpFloatingPanel()
        setUpTitleView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private
    private func fetchWatchlistData() {
        let symbols = PersistenceManager.shared.watchlist
        
        let group = DispatchGroup()
        
        for symbol in symbols {
            group.enter()
            //Fetch market data per symbol
            //watchlistMap[symbol] = ["some string"]
            APICaller.shared.marketData(for: symbol) { [weak self] result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let data):
                    let candleSticks = data.candleSticks
                    self?.watchlistMap[symbol] = candleSticks
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.createViewModels()
            self?.tableView.reloadData()
            
        }
    }
    private func createViewModels() {
        var viewModels = [WatchListTableViewCell.ViewModel]()
        
        for (symbol, candleSticks) in watchlistMap {
            let changePercentage = getChangePercentage(
                symbol: symbol,
                for: candleSticks
            )
            viewModels.append(
                .init(symbol: symbol,
                      companyName: UserDefaults.standard.string(forKey: symbol) ?? "Company",
                      price: getLatestClosingPrice(from: candleSticks),
                      changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                      changePercentage: .percentage(from: changePercentage),
                      //"\(changePercentage)"
                      chartViewModel: .init(
                        data: candleSticks.reversed().map { $0.close },
                        showLegend: false,
                        showAxis: false)
                )
            )
        }
        self.viewModels = viewModels
        
        //print("\n\n\(viewModels)\n\n")
    }
    
    private func getChangePercentage(symbol: String, for data: [CandleStick]) -> Double {
        let latestDate = Date().addingTimeInterval(-((3600 * 24) * 2))
        //let latestDate = data[0].date
        guard let latestClose = data.first?.close,
              let priorClose = data.first(where: {
                Calendar.current.isDate($0.date, inSameDayAs: latestDate)
              })?.close else {
            return 0
        }
        
        print("\(symbol) Current: (\(latestDate)) \(latestClose) | Prior: \(priorClose)")
        
        // - and + check
        let diff = 1 - (Double(priorClose) / Double(latestClose))
        
        print("\(symbol): \(diff)")
        return diff
    }
    
    private func getLatestClosingPrice(from data: [CandleStick]) -> String {
        guard let closingPrice = data.first?.close else {
            return ""
        }
        
        return .formatted(number: closingPrice)//"\(closingPrice)"
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpFloatingPanel() {
        let vc = NewsViewController(type: .topStories)//(type: .compan(symbol: "CPNG"))
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.tableView)
        //panel.delegate = self 같다 (delegate: self)와
    }
    
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
//         Update results controller
        
    }
    
    
}

extension WatchListViewController: SearchResultViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        // Present stock details for given selection
        print("Did select \(searchResult.displaySymbol)")
    }
    
    
}

extension WatchListViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = (fpc.state == .full)
    }
}

extension WatchListViewController: UITableViewDelegate,
                                   UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WatchListTableViewCell.identifier,
                for: indexPath
        ) as? WatchListTableViewCell else {
            fatalError()
        }
        cell.delegate = self
        cell.configure(with: viewModels[indexPath.row])
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WatchListTableViewCell.preferredHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension WatchListViewController: WatchListTableViewCellDelegate {
    func didUpdateMaxWidth() {
        // Optimize: Only refresh rows prior to the current row that changes the max width
        tableView.reloadData()
    }
}
