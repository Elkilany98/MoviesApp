//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation
import RealmSwift

class SearchViewModel {
    
    let apiNetwork:NetworkManagerProtocol
    private var searchList : [GeneralList] = [GeneralList]()
    init(apiNetwork : NetworkManagerProtocol = NetworkManager()) {
        self.apiNetwork = apiNetwork
    }
    private let realm = try! Realm()
    var reloadTableViewClosure : (()->())?
    var showAlertClosure : (()->())?
    var updateLoadingStatus : (()->())?
    var tempList = [GeneralCellViewModel]()

    private var pageCount = 1
    private var isGetMoreMovies = false
    private var searchText = "A"
    
    private var cellViewModel : [GeneralCellViewModel] = [GeneralCellViewModel](){
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    var state : State = .isEmpty {
        didSet{
            self.updateLoadingStatus?()
        }
    }
    
    
    var alertMessage:String? {
        didSet{
            self.showAlertClosure?()
        }
    }
    
    var numberOfCellForRow : Int{
        return cellViewModel.count
    }
    
    func getSearchList(searchText:String){
        self.isGetMoreMovies = true
        state = .isLoading
        
        apiNetwork.getSearchMoviesNetwork(page:"\(pageCount)" ,searchText: searchText) { response in
            switch response {
            case .success(let value):
                print("Current Page Number", self.pageCount)
                guard let list = value.results else {return}

                self.state = .isGetData
                self.fetchsearchList(topRatedArr: list)
                
                self.pageCount+=1
                self.isGetMoreMovies = false
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = Constants.InternetConnection.noInternet.rawValue
                print("erreor", error)
            }
        }
    }
    
    func getCellViewModel(index : IndexPath)->GeneralCellViewModel{
        return cellViewModel[index.row]
    }
    
    private func fetchsearchList(topRatedArr :[GeneralList]){
     
        self.searchList = topRatedArr
        for movie in topRatedArr {
            tempList.append(createCellViewModelFunctionality(movie: movie))
        }
        self.cellViewModel = tempList
    }
    
    func createCellViewModelFunctionality(movie:GeneralList) -> GeneralCellViewModel {
        let urlPathImage = ("https://image.tmdb.org/t/p/w500" + (movie.backdropPath ?? "" ))
            return GeneralCellViewModel(id: movie.id ?? 0 , backdropPath: urlPathImage, originalTitle:movie.originalTitle ?? "" , voteAverage: movie.voteAverage ?? 0.0)
    }
    
    func paginateTopRatedMoviesData(indexPaths:[IndexPath]){
        for index in indexPaths {
            if index.row >= numberOfCellForRow - 3 && !isGetMoreMovies {
                getSearchList(searchText: searchText)
                break
            }
        }
    }
    
    func getMoviesBasedOnTextSearch(_ searchText : String){
        tempList.removeAll()
        self.state = .isTypSearchText
        self.searchText = searchText
        getSearchList(searchText: searchText)
    }
    
    
    func addToRealmDateBase(indexPath:IndexPath){
        let favorite = FavoriteModel()
        let moviesIDs   = Array(realm.objects(FavoriteModel.self)).map{$0.movieID}
        let ifMoviesIDExist =  moviesIDs.contains("\(cellViewModel[indexPath.row].id ?? 0)")
        if ifMoviesIDExist == true  {
            print("this Movies is Exist")
            self.state = .error
            self.alertMessage = "This Movie Already Existed on Favorite list"
            return
        }
        
        
        favorite.movieID = "\(cellViewModel[indexPath.row].id ?? 0)"
        favorite.movieTitle = cellViewModel[indexPath.row].originalTitle ?? ""
        favorite.movieVoteAverage = "\(cellViewModel[indexPath.row].voteAverage ?? 0.0)"
        favorite.movieImage = cellViewModel[indexPath.row].backdropPath ?? ""
        
        realm.beginWrite()
        realm.add(favorite)
        try! realm.commitWrite()
        self.state = .intervalError
        self.alertMessage = "The movie has been added to favourites"
    }
    
    
}

