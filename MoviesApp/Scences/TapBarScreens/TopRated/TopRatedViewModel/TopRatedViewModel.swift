//
//  TopRatedViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation
import RealmSwift

class TopRatedViewModel {
    
    let apiNetwork:NetworkManagerProtocol
    private var topRatedList : [GeneralList] = [GeneralList]()
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
    
    fileprivate var cellViewModel : [GeneralCellViewModel] = [GeneralCellViewModel](){
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
    
    func getTopRatedList(){
        self.isGetMoreMovies = true
        state = .isLoading
        
        apiNetwork.getTopRatedMoviesNetwork(page:"\(pageCount)") { response in
            switch response {
            case .success(let value):
                print("Current Page Number", self.pageCount)
                guard let list = value.results else {
                    return
                }
                
                if list.count == 0 || list.isEmpty == true {
                    self.state = .isEmptyResult
                    self.alertMessage = "There is no data"

                }
                
                self.state = .isGetData
                self.fetchTopRatedList(topRatedArr: list)
                
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
    
    private func fetchTopRatedList(topRatedArr :[GeneralList]){
        self.topRatedList = topRatedArr
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
                getTopRatedList()
                break
            }
        }
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
    
    func gotoMoviesDetails(indexPath : IndexPath)-> String {
        let moviesDetails = cellViewModel[indexPath.row]
        return "\(moviesDetails.id ?? 0 )"
    }
    
    
}
