//
//  PagerTabStripName.swift
//  mini_skills
//
//  Created by 현은백 on 2021/08/30.
//

import XLPagerTabStrip

class PagerStripName: ButtonBarPagerTabStripViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
        let navHeight = navigationController?.navigationBar.frame.size.height ?? 0
        print(navHeight)
        
        
        buttonBarView.frame = CGRect(x: 0,
                                     y: navHeight,
                                     width: view.bounds.width, height: 40)
    
//        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
//        buttonBarView.topAnchor.constraint(equalTo: view.topAnchor,
//                                           constant: navHeight).isActive = true
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .yellow
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarHeight = 1
        settings.style.buttonBarMinimumLineSpacing = 10
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 5
        settings.style.buttonBarRightContentInset = 2
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?,
                                                       newCell: ButtonBarViewCell?,
                                                       progressPercentage: CGFloat,
                                                       changeCurrentIndex: Bool,
                                                       animated: Bool) -> Void in
            guard  changeCurrentIndex == true else {
                return
            }
            oldCell?.label.textColor = .yellow
            newCell?.label.textColor = .black
            
        }
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let a = A_ViewController()
        a.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let b = B_ViewController()
        return [A_ViewController(), B_ViewController()]
    }
}
