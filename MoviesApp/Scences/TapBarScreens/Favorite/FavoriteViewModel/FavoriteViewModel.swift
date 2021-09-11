//
//  FavoriteViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation
import RealmSwift
class FavoriteViewModel {
    
    var reloadTableViewClosure : (()->())?
    var emptyFavoriteCountClosure : (()->())?

    var favoriteArr:Results<FavoriteModel>!
    private let realm = try! Realm()
    
    
    func getProvidersFromRealmData(){
        do {
            favoriteArr  = realm.objects(FavoriteModel.self)
        }
        reloadTableViewClosure?()
    }
    
    func getCellViewModel(index : IndexPath)->FavoriteModel{
        return favoriteArr[index.row]
    }

    var numberOfCellForRow : Int{
        return favoriteArr.count
    }
    
    
    func checkFavoriteArrayCount(){
        if favoriteArr.count == 0 || favoriteArr.isEmpty  {
            emptyFavoriteCountClosure?()
        }
    }
    
    func deleteMovieFromFav(index:IndexPath){
        let  movies = favoriteArr[index.row]
            self.realm.beginWrite()
            self.realm.delete(movies)
            try! self.realm.commitWrite()
           reloadTableViewClosure?()

        }
    
    
    func gotoMoviesDetails(indexPath : IndexPath)-> String {
        let moviesDetails = favoriteArr[indexPath.row]
        return moviesDetails.movieID
    }
    
}
