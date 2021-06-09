//
/*
 
 * Rupeso
 * Created by : Leela Prasad on  04/04/19
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
*/

import UIKit

class TokenCollViewFlowLayout: UICollectionViewFlowLayout {
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
    var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
    
    var leftMargin: CGFloat = self.sectionInset.left
    
    for attributes in attributesForElementsInRect! {
      if (attributes.frame.origin.x == self.sectionInset.left) {
        leftMargin = self.sectionInset.left
      } else {
        var newLeftAlignedFrame = attributes.frame
        
        if leftMargin + attributes.frame.width < self.collectionViewContentSize.width {
          newLeftAlignedFrame.origin.x = leftMargin
        } else {
          newLeftAlignedFrame.origin.x = self.sectionInset.left
        }
        
        attributes.frame = newLeftAlignedFrame
      }
      leftMargin += attributes.frame.size.width + 8
      newAttributesForElementsInRect.append(attributes)
    }
    
    return newAttributesForElementsInRect
  }
}
