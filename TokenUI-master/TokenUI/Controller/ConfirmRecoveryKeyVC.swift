//
/*
 
 * Rupeso
 * Created by : Leela Prasad on  04/04/19
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
*/

import UIKit

class ConfirmRecoveryKeyVC: UIViewController {
  
  private var shuffledSeedArray = [Token]()
  private var correctSeedArray = [Token]()
  private var topCollView: DynmicHeightCollectionView!
  private var bottomCollView: DynmicHeightCollectionView!
  private var scrollView = UIScrollView.init()
  private var contentView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.setupViews()
    self.fetchShuffledRecoveryKey()
  }
  
  private func setupViews() {
    
    self.navigationItem.title = "Confirm Recovery Key"
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.translatesAutoresizingMaskIntoConstraints = false

    let heightConstraint = NSLayoutConstraint.init(item: contentView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
    heightConstraint.priority = UILayoutPriority.init(200)
    
    self.view.addSubview(scrollView)
    self.view.addConstraints([
      self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
      self.scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
      self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      ])
    
    self.scrollView.addSubview(contentView)
    let padding = self.navigationController?.navigationBar.frame.maxY ?? 0
    self.scrollView.addConstraints([
      self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -1 * padding),
      self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
      self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
      ])
    
    self.view.addConstraints([
      self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
      heightConstraint,
      ])
    
    let topLabel = returnLabel(with: "Verify your Recovery Key.")
    let bottomLabel = returnLabel(with: "Please, tap each word in the correct order of your seed.")
   
    self.topCollView = returnCollView()
    self.topCollView.register(TokenMainCell.self, forCellWithReuseIdentifier: TokenMainCell.identifier)
    self.topCollView.layer.cornerRadius = 5.0
    self.topCollView.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.4666666667, blue: 0.7215686275, alpha: 1).cgColor
    self.topCollView.layer.borderWidth = 1.25
    self.topCollView.isDynamicSizeRequired = true
    
    self.bottomCollView = returnCollView()
    self.bottomCollView.register(TokenListCell.self, forCellWithReuseIdentifier: TokenListCell.identifier)

    topLabel.setContentHuggingPriority(.init(rawValue: 800), for: .vertical)
    bottomLabel.setContentHuggingPriority(.init(rawValue: 799), for: .vertical)
    let topStack = UIStackView(arrangedSubviews: [topLabel, topCollView])
    topStack.translatesAutoresizingMaskIntoConstraints = false
    topStack.axis = .vertical
    topStack.spacing = 8.0
    
    let bottomStack = UIStackView(arrangedSubviews: [bottomLabel, bottomCollView])
    bottomStack.translatesAutoresizingMaskIntoConstraints = false
    bottomStack.axis = .vertical
    
    //Verify Button
    let verifyButton = UIButton.init(frame: .zero)
    verifyButton.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    verifyButton.setTitle("VERIFY", for: .normal)
    verifyButton.setTitleColor(.white, for: .normal)
    verifyButton.addTarget(self, action: #selector(onClickOfButtons(_:)), for: .touchUpInside)
    verifyButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(verifyButton)
    
    self.contentView.addSubview(topStack)
    self.contentView.addSubview(bottomStack)
    self.contentView.addSubview(verifyButton)
    
    self.contentView.addConstraints([
      
      topStack.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
      topStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      topStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
      topStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
      
      bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 16),
      bottomStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      bottomStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
//      bottomStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
      bottomStack.heightAnchor.constraint(greaterThanOrEqualToConstant: self.bottomCollView.contentSize.height + 30),
      bottomStack.bottomAnchor.constraint(equalTo: verifyButton.topAnchor, constant: -16),

      verifyButton.topAnchor.constraint(equalTo: bottomStack.bottomAnchor, constant: 16),
      verifyButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      verifyButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
      verifyButton.heightAnchor.constraint(equalToConstant: 50),
      verifyButton.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
      
      ])
  }
  
  private func fetchShuffledRecoveryKey() {
    
    let spinner = Spinner.init()
    spinner.showInView(self.view, inBounds: self.view.bounds)
    
    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
      spinner.hide()
      for (indx,str) in ["BasicOperators", "Strings", "Characters", "CollectionTypes", "ControlFlow", "Closures", "AdvancedOperators", "AccessControl", "Memory", "Generics", "Error", "Deinitialization","a","a"].enumerated() {
        self.shuffledSeedArray.append(Token(title: str, id: indx, selected: false))
      }
      self.bottomCollView.reloadData()
      self.bottomCollView.layoutIfNeeded()
    }
  }
  
  private func sendArrangedSeedToRemote() {
    
    let alert = UIAlertController.init(title: "Sending", message: "Please wait...", preferredStyle: .alert)
    alert.view.tintColor = #colorLiteral(red: 0.2588235294, green: 0.3098039216, blue: 0.5215686275, alpha: 1)
    alert.addAction(.init(title: "Cancel", style: .default, handler: nil))
    alert.addAction(.init(title: "Continue", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
  @objc func onClickOfButtons(_ sender: UIButton) {
    
    self.sendArrangedSeedToRemote()
  }
  
  private func returnLabel(with text: String) -> UILabel {
    
    let labl = UILabel()
    labl.text = text
    labl.font = UIFont.systemFont(ofSize: 16)
    labl.numberOfLines = 0
    labl.textColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
    labl.translatesAutoresizingMaskIntoConstraints = false
    return labl
  }
  
  private func returnCollView() -> DynmicHeightCollectionView {
    
    let layout = TokenCollViewFlowLayout.init()
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.scrollDirection = .vertical
    let collView = DynmicHeightCollectionView.init(frame: .zero, collectionViewLayout: layout)
    collView.translatesAutoresizingMaskIntoConstraints = false
//    collView.isScrollEnabled = false
    collView.delegate = self
    collView.dataSource = self
    collView.backgroundColor = .clear
    return collView
  }
}

extension ConfirmRecoveryKeyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  //Datasource Methods
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == topCollView {
      return correctSeedArray.count
    } else {
      return shuffledSeedArray.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == topCollView {
      
      guard let cell = self.topCollView.dequeueReusableCell(withReuseIdentifier: TokenMainCell.identifier, for: indexPath) as? TokenMainCell else { return TokenMainCell() }
      cell.token = self.correctSeedArray[indexPath.item]
      return cell
    } else {
      
      guard let cell = self.bottomCollView.dequeueReusableCell(withReuseIdentifier: TokenListCell.identifier, for: indexPath) as? TokenListCell else { return TokenListCell() }
      cell.token = self.shuffledSeedArray[indexPath.item]
      cell.backgroundColor = self.shuffledSeedArray[indexPath.item].selected ?  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.4039215686, green: 0.4666666667, blue: 0.7215686275, alpha: 1)
      return cell
    }
  }
  
//  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    if collectionView == botCollView {
//      guard let listCell = cell as? TokenListCell else { return }
//      listCell.token = self.shuffledSeedArray[indexPath.item]
//      listCell.isSelected = self.shuffledSeedArray[indexPath.item].selected
//    }
//  }
  
  //Delegate Methods
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if collectionView == topCollView {
      //Delete from top and enable the same in the bottom coll view
      var token = self.correctSeedArray[indexPath.item]
      token.selected = false
      self.correctSeedArray.remove(at: indexPath.item)
      self.topCollView.deleteItems(at: [indexPath])
      
      self.topCollView.reloadData()
      self.topCollView.collectionViewLayout.invalidateLayout()
      
      if let row = self.shuffledSeedArray.firstIndex(where: {$0.id == token.id}) {
        self.shuffledSeedArray[row] = token
      }
      
      self.topCollView.reloadData()
      self.topCollView.layoutIfNeeded()
      self.bottomCollView.reloadData()
      self.bottomCollView.layoutIfNeeded()
      
    } else {
      //Bot CollView
      var token = shuffledSeedArray[indexPath.item]
      guard token.selected == false else {
        print("Not selectable")
        return
      }
      token.selected = true
      
      if let row = self.shuffledSeedArray.firstIndex(where: {$0.id == token.id}) {
        self.shuffledSeedArray[row] = token
      }
      self.correctSeedArray.append(token)
      self.topCollView.reloadData()
      self.topCollView.layoutIfNeeded()
      self.bottomCollView.reloadData()
      self.bottomCollView.layoutIfNeeded()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var text = ""
    
    if collectionView == topCollView {
      text = self.correctSeedArray[indexPath.item].title
    } else {
      text = self.shuffledSeedArray[indexPath.item].title
    }
    
    let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:16.0)]).width + 30.0
    
    if collectionView == topCollView {
      return CGSize(width: min(cellWidth + 35, topCollView.contentSize.width - 16), height: 30.0)
    } else {
      return CGSize(width: cellWidth, height: 30.0)
    }
  }
}
