//
//  MoviesDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import Foundation

class MoviesDetailsViewModel {
    
    
    var updateLoadingStatus : (()->())?

    var state : State = .isEmpty {
        didSet{
            self.updateLoadingStatus?()
        }
    }
    
    
}
