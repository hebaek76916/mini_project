//
/*
 
 * Rupeso
 * Created by : Leela Prasad on  04/04/19
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
*/

import UIKit

class TokenMainCell: BaseCollectionViewCell {
  
  static let identifier = "TokenMainCell"
  
  var token: Token? {
    didSet{
      guard let sender = self.token else { return }
      self.titleLabel.text = sender.title
    }
  }
  
  var titleLabel: UILabel = {
    
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.textAlignment = .center
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return lbl
  }()
  
  var cancelButton: UIButton = {
    
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("x", for: .normal)
    btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    btn.setContentHuggingPriority(.init(900), for: .horizontal)
    btn.isUserInteractionEnabled = false
    return btn
  }()
  
  override func setupViews() {
    
    self.titleLabel.text = nil
    self.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.4666666667, blue: 0.7215686275, alpha: 1)
    self.layer.cornerRadius = 4.0

    let stack = UIStackView(arrangedSubviews: [titleLabel, cancelButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.distribution = .fillProportionally
    stack.spacing = 8
    
    addSubview(stack)
    self.addConstraints([
      stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
      ])
  }
}


class TokenListCell: BaseCollectionViewCell {
  
  static let identifier = "TokenListCell"
  
  var token: Token? {
    didSet{
      guard let sender = self.token else { return }
      self.titleLabel.text = sender.title
    }
  }
  
  var titleLabel: UILabel = {
    
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.textAlignment = .center
    //    lbl.adjustsFontSizeToFitWidth = true
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.lineBreakMode = .byTruncatingMiddle
    lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return lbl
  }()
  
  override func setupViews() {
    
    self.titleLabel.text = nil
    self.layer.cornerRadius = 4.0

    
    addSubview(titleLabel)
    self.addConstraints([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
      ])
  }
}

