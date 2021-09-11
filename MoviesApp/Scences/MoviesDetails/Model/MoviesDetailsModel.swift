//
//  MoviesDetailsModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

// MARK: - Welcome
struct MoviesDetailsModel: Codable {
    let backdropPath: String?
    let genres: [Genre]?
    let originalTitle, overview: String?
    let title,releaseDate: String?
    let voteAverage ,voteCount: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres,title,overview
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
