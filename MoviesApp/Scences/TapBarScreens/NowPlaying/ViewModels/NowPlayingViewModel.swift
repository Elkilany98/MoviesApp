//
//  NowPlayingViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import Foundation
class NowPlayingViewModel {
    
    let apiNetwork:NetworkManagerProtocol
    private var nowPlayingList : [GeneralList] = [GeneralList]()
    init(apiNetwork : NetworkManagerProtocol = NetworkManager()) {
        self.apiNetwork = apiNetwork
    }
    
    var reloadTableViewClosure : (()->())?
    var showAlertClosure : (()->())?
    var updateLoadingStatus : (()->())?
    var tempList = [NowPlayingCellViewModel]()

    private var pageCount = 1
    private var isGetMoreMovies = false
    
    private var cellViewModel : [NowPlayingCellViewModel] = [NowPlayingCellViewModel](){
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
    
    func getMoviesList(){
        self.isGetMoreMovies = true
        state = .isLoading
        
        apiNetwork.getNowPlayingMoviesNetwork(page:"\(pageCount)") { response in
            switch response {
            case .success(let value):
                print("Current Page Number", self.pageCount)
                guard let list = value.results else {
                    return
                }
                
                self.state = .isGetData
                self.fetchTheMoviesList(nowPlaying: list)
                
                self.pageCount+=1
                self.isGetMoreMovies = false
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = Constants.InternetConnection.noInternet.rawValue
                print("erreor", error)
            }
        }
    }
    
    func getCellViewModel(index : IndexPath)->NowPlayingCellViewModel{
        return cellViewModel[index.row]
    }
    
    private func fetchTheMoviesList(nowPlaying :[GeneralList]){
        self.nowPlayingList = nowPlaying
        for movie in nowPlaying {
            tempList.append(createCellViewModelFunctionality(movie: movie))
        }
        self.cellViewModel = tempList
    }
    
    func createCellViewModelFunctionality(movie:GeneralList) -> NowPlayingCellViewModel {
        let urlPathImage = ("https://image.tmdb.org/t/p/w500" + (movie.backdropPath ?? "" ))
            return NowPlayingCellViewModel(id: movie.id ?? 0 , backdropPath: urlPathImage, originalTitle:movie.originalTitle ?? "" , voteAverage: movie.voteAverage ?? 0.0)
    }
    
    func paginateMoviesData(indexPaths:[IndexPath]){
        for index in indexPaths {
            if index.row >= numberOfCellForRow - 3 && !isGetMoreMovies {
                getMoviesList()
                break
            }
        }
        
        
    }
    
    
    
    
}
