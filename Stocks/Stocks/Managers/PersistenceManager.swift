//
//  PersistenceManager.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/11.
//

import Foundation


final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        
    }
    
    private init() {
        
    }
    
    // MARK: - Public
    
    public var watchlist: [String] {
        return []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeFromWathchlist() {
        
    }
    
    // MARK : - Private
    
    private var hasOnboarded: Bool {
        return false
    }
}
