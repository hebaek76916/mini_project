//
//  NewStory.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/14.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
