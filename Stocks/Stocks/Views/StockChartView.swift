//
//  StockChartView.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/21.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // Reset the chartView
    func reset() {
        
    }
    
    func configure(with viewModel: ViewModel) {
        
    }

}
