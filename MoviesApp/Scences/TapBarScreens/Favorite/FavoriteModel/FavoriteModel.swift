//
//  FavoriteModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import RealmSwift

class FavoriteModel:Object {
    @Persisted var movieID = ""
    @Persisted var movieImage = ""
    @Persisted var movieTitle = ""
    @Persisted var movieVoteAverage = ""
}
