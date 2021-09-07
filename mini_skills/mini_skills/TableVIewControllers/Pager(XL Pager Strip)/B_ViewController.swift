//
//  B_ViewController.swift
//  mini_skills
//
//  Created by 현은백 on 2021/08/30.
//

import UIKit
import XLPagerTabStrip

class B_ViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BLUE")
    }

}
