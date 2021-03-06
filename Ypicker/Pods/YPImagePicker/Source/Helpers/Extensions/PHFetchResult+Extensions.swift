//
//  PHFetchResult + IndexPath.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 26/01/2018.
//  Copyright ยฉ 2018 Yummypets. All rights reserved.
//

import Foundation
import Photos

internal extension PHFetchResult where ObjectType == PHAsset {
    
    func assetsAtIndexPaths(_ indexPaths: [IndexPath]) -> [PHAsset] {
        
        if indexPaths.count == 0 { return [] }
        
        var assets: [PHAsset] = []
        
        assets.reserveCapacity(indexPaths.count)
        print("๐", indexPaths.count)
        
        var new = indexPaths
//
//        collectionView ์ dataSource count๊ธฐ๋ฐ์ผ๋ก ํ๊ธฐ ๋๋ฌธ์
//        ์ง๊ธ ์์๋ก + 1 ํด์คฌ์์? ๊ทธ๋ผ... 0๋ถํฐ ์์ํ๋คํ๋ฉด ๋ง์ง๋ง asset์ ์๋๋ฐ
//        ์ฑ์์ผํ๋จ ๋ง์ด์ง? ๊ทธ๋ผ ์ง์์ค ๊ทธ๋ผ ๋ผ
//
        let newIdxPaths = new[0..<indexPaths.count - 1]
        print("๐", newIdxPaths.count)
        
        for indexPath in newIdxPaths {

            let asset = self[indexPath.item]
            assets.append(asset)
        }
        
        print("๐จ",assets.count)
        return assets
    }
}
