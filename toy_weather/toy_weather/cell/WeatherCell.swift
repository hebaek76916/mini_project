//
//  WeatherCell.swift
//  toy_weather
//
//  Created by 현은백 on 2021/02/14.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    static let identifier: String = "WeatherCell"
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        //label.font = UIFont.boldSystemFont(ofSize: 14)
        label.font = UIFont(name: "Palatino", size: 17)
        return label
    }()
    
    let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "MAX"
        label.font = UIFont(name: "Palatino", size: 17)
        //label.font = UIFont(name: "NoteWorthy", size: 17)//UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    let minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "MIN"
        //label.font = UIFont.boldSystemFont(ofSize: 13)
        label.font = UIFont(name: "Palatino", size: 17)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(weatherIcon)
        self.contentView.addSubview(minTempLabel)
        self.contentView.addSubview(maxTempLabel)
        
        dayLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalTo(self.contentView)
        }
        
        weatherIcon.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.height.equalTo(self.contentView.frame.height)
            make.width.equalTo(self.contentView.frame.height)
            
        }
        
        minTempLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-70)
            make.centerY.equalToSuperview()
        }
        
        maxTempLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
