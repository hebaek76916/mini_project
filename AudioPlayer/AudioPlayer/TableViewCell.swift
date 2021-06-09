//
//  TableViewCell.swift
//  AudioPlayer
//
//  Created by 현은백 on 2021/05/16.
//

import UIKit

class TableViewCell: UITableViewCell {

//    let titleLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
