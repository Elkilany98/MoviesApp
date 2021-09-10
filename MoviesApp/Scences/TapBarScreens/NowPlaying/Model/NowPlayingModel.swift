//
//  NowPlayingModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation

struct NowPlayingModel: Codable {
    let page: Int?
    let statusMessage :String?
    let results: [NowPlayingList]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case  page, results
        case statusMessage = "status_message"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct NowPlayingList: Codable {
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
