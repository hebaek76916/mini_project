//
/*
 
 * Rupeso
 * Created by : Leela Prasad on  04/04/19
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
*/

import UIKit

class DynmicHeightCollectionView: UICollectionView {
  
  var isDynamicSizeRequired = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
      
      if self.intrinsicContentSize.height > frame.size.height {
        self.invalidateIntrinsicContentSize()
      }
      if isDynamicSizeRequired {
        self.invalidateIntrinsicContentSize()
      }
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
