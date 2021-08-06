//
//  PersistenceManager.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/11.
//

import Foundation

// ["APPL", "MSFT", "SNAP"]
// [APPL: Apple Inc.]

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchlistKey = "watchlist"
    }
    
    private init() {
        
    }
    
    // MARK: - Public
    
    public var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDeaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchlistKey) ?? []
    }
    
    public func watchlistContains(symbol: String) -> Bool {
        return watchlist.contains(symbol)
    }
    
    public func addToWatchlist(symbol: String, companyName: String) {
        var current = watchlist
        
        current.append(symbol)
        userDefaults.set(current, forKey: Constants.watchlistKey)
        userDefaults.set(companyName, forKey: symbol)
        
        //NotificationCenter.default.post(name: .didAddToWatchlist, object: nil)
        NotificationCenter.default.post(name: .didAddToWatchList, object: nil)
    }
    
    public func removeFromWathchlist(symbol: String) {
        var newList = [String]()
        
        userDefaults.set(nil, forKey: symbol)
        for item in watchlist where item != symbol { // Where이 for 문에서 조건(?)으로 쓰일 수 있구나! 즉 item중 symbol이 아닌!
            newList.append(item)
        }
        
        userDefaults.set(newList, forKey: Constants.watchlistKey)
    }
    
    // MARK : - Private
    
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey: "hasOnboarded")
    }
    
    private func setUpDeaults() {
        let map: [String: String] = [
            "APPL": "Apple Inc",
            "MSFT": "Microsoft Corporation",
            "SNAP": "Snap Inc.",
            "GOOG": "Alphabet",
            "AMZN": "Amazon.com, Inc.",
            "WORK": "Slack Technologies",
            "FB": "Facebook Inc.",
            "NVDA": "Nvidia Inc.",
            "CPNG": "Coopang Inc.",
            "PINS": "Pinterest"
        ]
        
        let symbols = map.keys.map { $0 }
        userDefaults.set(symbols, forKey: Constants.watchlistKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol)
        }
    }
}
