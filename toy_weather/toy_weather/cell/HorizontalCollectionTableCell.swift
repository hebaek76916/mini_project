//
//  HorizontalCollectionTableCell.swift
//  toy_weather
//
//  Created by 현은백 on 2021/02/16.
//

import UIKit
import SnapKit

class HorizontalCollectionTableCell: UITableViewCell {

    static let identifier = "HorizontalCollectionTableCell"
    //MARK : Cell components
    let flowLayout = UICollectionViewFlowLayout()
    let collectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
        let collectionViewWidth = UIScreen.main.bounds.width - 48
        let collectionView = UICollectionView()//(frame: .init(x: 0, y: 0, width: collectionViewWidth, height: 20),collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.collectionView.frame = .init(x: 0, y: 0, width: 10, height: 10)
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(self.contentView)
            //make.height.equalToSuperview()
        }
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "hcell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension HorizontalCollectionTableCell: UICollectionViewDelegate {
    
}
extension HorizontalCollectionTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hcell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
