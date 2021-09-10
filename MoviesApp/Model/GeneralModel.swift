//
//  GeneralResponse.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Foundation


struct GeneralModel: Codable {
    let page: Int?
    let statusMessage :String?
    let results: [GeneralList]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case  page, results
        case statusMessage = "status_message"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct GeneralList: Codable {
    let id: Int?
    let backdropPath: String?
    let originalTitle: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"

    }
}
