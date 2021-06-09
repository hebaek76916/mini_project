//
//  ViewController.swift
//  COVIDCHART_IOSACADEMY
//
//  Created by 현은백 on 2021/06/09.
//

import UIKit


// Data of COVID Cases
class ViewController: UIViewController {

    /*
     - Call APIs
     - ViewModels
     - View: Table
     - Filter / User Pick the State
     - Update UI
     */
    
    private var scope: APICaller.DataScope = .national
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "COVID Cases"
        createFilterButton()
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getCovidData(for: scope) { result in
            switch result {
            case .success(let data):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createFilterButton() {
        let buttonTitle: String = {
            switch scope {
            case .national: return "National"
            case .state(let state): return state.name
            }
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title:buttonTitle,
            style: .done,
            target: self,
            action: #selector(didTapFilter)
        )
    }
    @objc private func didTapFilter() {
        let vc = FilterViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }


}

