//
//  PHFetchResult + IndexPath.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 26/01/2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation
import Photos

internal extension PHFetchResult where ObjectType == PHAsset {
    
    func assetsAtIndexPaths(_ indexPaths: [IndexPath]) -> [PHAsset] {
        
        if indexPaths.count == 0 { return [] }
        
        var assets: [PHAsset] = []
        
        assets.reserveCapacity(indexPaths.count)
        print("🕊", indexPaths.count)
        
        var new = indexPaths
//
//        collectionView 의 dataSource count기반으로 하기 때문에
//        지금 임의로 + 1 해줬잖아? 그럼... 0부터 시작한다하면 마지막 asset은 없는데
//        채워야한단 말이지? 그럼 지워줘 그럼 돼
//
        let newIdxPaths = new[0..<indexPaths.count - 1]
        print("💜", newIdxPaths.count)
        
        for indexPath in newIdxPaths {

            let asset = self[indexPath.item]
            assets.append(asset)
        }
        
        print("🎨",assets.count)
        return assets
    }
}
