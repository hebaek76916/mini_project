//
//  YPLibraryVC+CollectionView.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 26/01/2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

extension YPLibraryVC {
    var isLimitExceeded: Bool { return selection.count >= YPConfig.library.maxNumberOfItems }
    
    func setupCollectionView() {
        v.collectionView.backgroundColor = YPConfig.colors.libraryScreenBackgroundColor
        v.collectionView.dataSource = self
        v.collectionView.delegate = self
        
        v.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        v.collectionView.register(YPLibraryViewCell.self, forCellWithReuseIdentifier: "YPLibraryViewCell")
        
        // Long press on cell to enable multiple selection
//        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
//        longPressGR.minimumPressDuration = 0.5
//        v.collectionView.addGestureRecognizer(longPressGR)
    }
    
    /// When tapping on the cell with long press, clear all previously selected cells.
    @objc func handleLongPress(longPressGR: UILongPressGestureRecognizer) {
//        if multipleSelectionEnabled || isProcessing || YPConfig.library.maxNumberOfItems <= 1 {
//            return
//        }
//        
//        if longPressGR.state == .began {
//            let point = longPressGR.location(in: v.collectionView)
//            guard let indexPath = v.collectionView.indexPathForItem(at: point) else {
//                return
//            }
//            startMultipleSelection(at: indexPath)
//        }
    }
    
    func startMultipleSelection(at indexPath: IndexPath) {
        currentlySelectedIndex = indexPath.row
        multipleSelectionButtonTapped()
        
        // Update preview.
        changeAsset(mediaManager.fetchResult[indexPath.row])
        
        // Bring preview down and keep selected cell visible.
        panGestureHelper.resetToOriginalState()
        if !panGestureHelper.isImageShown {
            v.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
        v.refreshImageCurtainAlpha()
    }
    
    // MARK: - Library collection view cell managing
    
    /// Removes cell from selection
    func deselect(indexPath: IndexPath) {
        // 눌린 인덱스는 1 -> 처리 해야할 image는 0
        // 지금 들어온 인덱스는 실제 눌린 인덱스보다 -1 된 인덱스임임
        if let positionIndex = selection.firstIndex(where: {
            //indexPath.row 보다 -1 이어야겠지?
            $0.assetIdentifier == mediaManager.fetchResult[indexPath.row - 1].localIdentifier
        }) {
            selection.remove(at: positionIndex)
            
            // Refresh the numbers
            var selectedIndexPaths = [IndexPath]()
            mediaManager.fetchResult.enumerateObjects { [unowned self] (asset, index, _) in
                if self.selection.contains(where: { $0.assetIdentifier == asset.localIdentifier }) {
                    selectedIndexPaths.append(IndexPath(row: index, section: 0))
                }
            }
            
            // selected Index Paths -> 한칸씩 +1 옮겨야함
            var real_selectedIndexPaths = [IndexPath]()
            for idxPth in selectedIndexPaths {
                real_selectedIndexPaths.append(IndexPath(item: idxPth.row + 1, section: 0))
            }
            v.collectionView.reloadItems(at: real_selectedIndexPaths)
            
            
            // Replace the current selected image with the previously selected one
            if let previouslySelectedIndexPath = real_selectedIndexPaths.last {
                
                let real_indexPath = IndexPath(row: indexPath.row + 1, section: 0)
                v.collectionView.deselectItem(at: real_indexPath, animated: false)
                
                v.collectionView.selectItem(at: previouslySelectedIndexPath, animated: false, scrollPosition: [])
                // 실제 current selectedIndex임
                currentlySelectedIndex = previouslySelectedIndexPath.row - 1
                
                //image result는 바뀌여야겟찌
                changeAsset(mediaManager.fetchResult[previouslySelectedIndexPath.row - 1])
            }
            
            checkLimit()
        }
    }
    
    /// Adds cell to selection
    func addToSelection(indexPath: IndexPath) {
        if !(delegate?.libraryViewShouldAddToSelection(indexPath: indexPath, numSelections: selection.count) ?? true) {
            return
        }
        
        let asset = mediaManager.fetchResult[indexPath.item]
        selection.append(
            YPLibrarySelection(
                index: indexPath.row,
                assetIdentifier: asset.localIdentifier
            )
        )
        checkLimit()
    }
    
    func isInSelectionPool(indexPath: IndexPath) -> Bool {
        return selection.contains(where: {
            $0.assetIdentifier == mediaManager.fetchResult[indexPath.row].localIdentifier
        })
    }
    
    /// Checks if there can be selected more items. If no - present warning.
    func checkLimit() {
        v.maxNumberWarningView.isHidden = !isLimitExceeded || multipleSelectionEnabled == false
    }
}

extension YPLibraryVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaManager.fetchResult.count + 1
    }
}

extension YPLibraryVC: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.8502783775, green: 0.5866859555, blue: 0.9166913629, alpha: 1)
            return cell
        } else {
            
            let plusOneIndex = IndexPath(row: indexPath.row - 1, section: 0)
            
            // Asset은 -1 해야 한다.
            let asset = mediaManager.fetchResult[indexPath.row - 1]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YPLibraryViewCell",
                                                                for: indexPath) as? YPLibraryViewCell else {
                fatalError("unexpected cell in collection view")
            }
            
            cell.representedAssetIdentifier = asset.localIdentifier
            
            cell.multipleSelectionIndicator.selectionColor =
                YPConfig.colors.multipleItemsSelectedCircleColor ?? YPConfig.colors.tintColor
            
            mediaManager.imageManager?.requestImage(for: asset,
                                                    targetSize: v.cellSize(),
                                                    contentMode: .aspectFill,
                                                    options: nil) { image, _ in
                
                // The cell may have been recycled when the time this gets called
                // set image only if it's still showing the same asset.
                if cell.representedAssetIdentifier == asset.localIdentifier && image != nil {
                    
                    cell.imageView.image = image
                    
                }
            }
            
            let isVideo = (asset.mediaType == .video)
            
            cell.durationLabel.isHidden = !isVideo
            
            cell.durationLabel.text = isVideo ? YPHelper.formattedStrigFrom(asset.duration) : ""
            
            cell.multipleSelectionIndicator.isHidden = !multipleSelectionEnabled
            
            cell.isSelected = currentlySelectedIndex == (indexPath.row)
            
            // Set correct selection number
            if let index = selection.firstIndex(where: { $0.assetIdentifier == asset.localIdentifier }) {
                
                let currentSelection = selection[index]
                if currentSelection.index < 0 {
                    selection[index] = YPLibrarySelection(index: indexPath.row - 1,
                                                          cropRect: currentSelection.cropRect,
                                                          scrollViewContentOffset: currentSelection.scrollViewContentOffset,
                                                          scrollViewZoomScale: currentSelection.scrollViewZoomScale,
                                                          assetIdentifier: currentSelection.assetIdentifier)
                }
                cell.multipleSelectionIndicator.set(number: index + 1) // start at 1, not 0
            } else {
                cell.multipleSelectionIndicator.set(number: nil)
            }
            
            // Prevent weird animation where thumbnail fills cell on first scrolls.
            UIView.performWithoutAnimation {
                cell.layoutIfNeeded()
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // tlf
        if indexPath.row == 0 {
            return
        }
        else {
            let previouslySelectedIndexPath = IndexPath(row: currentlySelectedIndex, section: 0)
            currentlySelectedIndex = indexPath.row
            
            changeAsset(mediaManager.fetchResult[indexPath.row - 1])
            panGestureHelper.resetToOriginalState()
            
            // Only scroll cell to top if preview is hidden.
            if !panGestureHelper.isImageShown {
                collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            }
            v.refreshImageCurtainAlpha()
            
            
            // 앞으로 밀려야(-1)겠지 원래값은 -1한 값이니까
            let real_indexPath = IndexPath(row: indexPath.row - 1, section: 0)
            
            if multipleSelectionEnabled {
                let cellIsInTheSelectionPool = isInSelectionPool(indexPath: real_indexPath)
                let cellIsCurrentlySelected = previouslySelectedIndexPath.row == currentlySelectedIndex
                if cellIsInTheSelectionPool {
                    if cellIsCurrentlySelected {
                        deselect(indexPath: indexPath)
                    }
                } else if isLimitExceeded == false {
                    addToSelection(indexPath: indexPath)
                }
                collectionView.reloadItems(at: [indexPath])
                collectionView.reloadItems(at: [real_indexPath])
                collectionView.reloadItems(at: [previouslySelectedIndexPath])
            } else {
                selection.removeAll()
                addToSelection(indexPath: real_indexPath)
                
                // Force deseletion of previously selected cell.
                // In the case where the previous cell was loaded from iCloud, a new image was fetched
                // which triggered photoLibraryDidChange() and reloadItems() which breaks selection.
                //
                
                let real_previouslySelectedIndexPath = IndexPath(row: previouslySelectedIndexPath.row - 1, section: 0)
                if let previousCell = collectionView.cellForItem(at: real_previouslySelectedIndexPath) as? YPLibraryViewCell {
                    previousCell.isSelected = false
                }
            }
        }

    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return isProcessing == false
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return isProcessing == false
    }
}

extension YPLibraryVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margins = YPConfig.library.spacingBetweenItems * CGFloat(YPConfig.library.numberOfItemsInRow - 1)
        let width = (collectionView.frame.width - margins) / CGFloat(YPConfig.library.numberOfItemsInRow)
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return YPConfig.library.spacingBetweenItems
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return YPConfig.library.spacingBetweenItems
    }
}
