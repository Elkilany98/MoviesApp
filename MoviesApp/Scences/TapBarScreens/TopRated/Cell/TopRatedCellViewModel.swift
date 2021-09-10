//
//  TopRatedCellViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Foundation

struct TopRatedCellViewModel: Codable {
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
