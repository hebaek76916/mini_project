//
//  MXSegmentedPagerViewController.swift
//  mini_skills
//
//  Created by 현은백 on 2021/08/31.
//

import UIKit
import MXSegmentedPager

class MXSegmentedPagerViewController: MXSegmentedPagerController {

    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.8502783775, green: 0.5866859555, blue: 0.9166913629, alpha: 1)
        
        segmentedPager.backgroundColor = .white
        
        //Parallax Header
        segmentedPager.parallaxHeader.view = headerView
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = 150
        
        //Segmented Control customization
        segmentedPager.segmentedControl.indicator.linePosition = .top
        segmentedPager.segmentedControl.textColor = .black
        segmentedPager.segmentedControl.selectedTextColor = .orange
        segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .orange
        
        let avc = A_ViewController()
        let bvc = B_ViewController()
        addChild(avc)
        addChild(bvc)
        view.addSubview(avc.view)
        avc.view.frame = view.bounds
        view.addSubview(bvc.view)
        bvc.view.frame = view.bounds
        
        avc.didMove(toParent: self)
        bvc.didMove(toParent: self)
        
    }
    
    
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return 2
    }
    
    override func viewSafeAreaInsetsDidChange() {
        segmentedPager.parallaxHeader.minimumHeight = view.safeAreaInsets.top
    }
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["TABLE", "WEB"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        print("progress \(parallaxHeader.progress)")
    }
    

}
