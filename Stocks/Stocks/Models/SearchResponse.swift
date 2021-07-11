//
//  SearchResponse.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/12.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}
struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
