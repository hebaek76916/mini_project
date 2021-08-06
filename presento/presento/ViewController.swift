//
//  ViewController.swift
//  presento
//
//  Created by 현은백 on 2021/08/05.
//

import UIKit
import CarPlay
import CarLensCollectionViewLayout

class ViewController: UIViewController {
    
    var imageArr: [String] = ["e1", "e2", "e3", "e4", "e5", "e6", "down"]
    var messageArr: [String] = ["은희야", "생일", "축하해", "정말 정말", "잘태어났어!", "🐣", "이제 내려줘⬇️" ]
    
    
    
    let collectionView: UICollectionView = {
        
        let layout = CarLensCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8502783775, green: 0.5866859555, blue: 0.9166913629, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 16,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.width - 32,
                                      height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}

extension ViewController: UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(imageArr.count, messageArr.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                      for: indexPath) as! CollectionViewCell
        cell.setting(name: imageArr[indexPath.row], title: messageArr[indexPath.row])
        
        return cell
    }
    
    
}
