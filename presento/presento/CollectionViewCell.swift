//
//  CollectionViewCell.swift
//  presento
//
//  Created by 현은백 on 2021/08/05.
//

import CarLensCollectionViewLayout

class CollectionViewCell: CarLensCollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    private var upperView: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 55)//.boldSystemFont(ofSize: 60)//Notosans 넣기
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "CarLens"
        return label
    }()
    
    private var bottomView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var imageView: UIImageView = {
        var view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    
    func setting(name: String, title: String = " ") {
        let image = UIImage(named: name)
        imageView.image = image
        upperView.text = title
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(topView: upperView, cardView: imageView, topViewHeight: 200)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
