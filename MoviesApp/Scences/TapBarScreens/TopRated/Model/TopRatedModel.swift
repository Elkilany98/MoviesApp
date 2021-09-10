//
//  TopRatedModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation

struct TopRatedModel: Codable {
    let page: Int?
    let results: [TopRatedList]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TopRatedList: Codable {
    let id: Int?
    let originalTitle: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
  
    }
}
