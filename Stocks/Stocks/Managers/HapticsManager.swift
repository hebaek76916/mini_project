//
//  HapticsManager.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/11.
//

import Foundation
import UIKit

final class HapticsManager {
    // Singleton
    static let shared = HapticsManager()
    
    private init() {
        
    }
    
    // MARK: - Public
    
    // Vibrate slightly for selection
    public func vibrateForSelection() {
        // Vibrate lightly for a selection tap interaction
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    /// Play haptic for given type interation
    /// - Parameter type: Type to vibrate for
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
}
