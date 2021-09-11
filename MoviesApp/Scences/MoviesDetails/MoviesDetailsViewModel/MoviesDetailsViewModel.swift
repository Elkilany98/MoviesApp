//
//  MoviesDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 11/09/2021.
//

import Foundation

class MoviesDetailsViewModel {
    
    let apiNetwork:NetworkManagerProtocol
     var generList : [Genre] = [Genre]()
    init(apiNetwork : NetworkManagerProtocol = NetworkManager()) {
        self.apiNetwork = apiNetwork
    }
    
    var reloadTableViewClosure : (()->())?
    var showAlertClosure : (()->())?
    var updateLoadingStatus : (()->())?
    var moviesDetailsClosure: ((MoviesDetailsModel)->())?
    var tempList = [GenerCellViewModel]()

    
    private var cellViewModel : [GenerCellViewModel] = [GenerCellViewModel](){
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
    
    func getMoviesDetailsList(moviesID:String){
        state = .isLoading
        
        apiNetwork.getMoviesDetailsNetwork(moviesID: moviesID) { response in
            switch response {
            case .success(let value):

                guard let list = value.genres else {
                    return
                }
                
                if list.count == 0 || list.isEmpty == true {
                    self.state = .isEmptyResult
                    self.alertMessage = "There is no data"
                }
                
                self.state = .isGetData
                self.moviesDetailsClosure?(value)
                self.fetchTheGenerList(nowPlaying: list)
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = Constants.InternetConnection.noInternet.rawValue
                print("erreor", error)
            }
        }
    }
    
    func getCellViewModel(index : IndexPath)->GenerCellViewModel{
        return cellViewModel[index.row]
    }
    
    private func fetchTheGenerList(nowPlaying :[Genre]){
        self.generList = nowPlaying
        for movie in nowPlaying {
            tempList.append(createCellViewModelFunctionality(gener: movie))
        }
        self.cellViewModel = tempList
    }
    
    func createCellViewModelFunctionality(gener:Genre) -> GenerCellViewModel {
        return GenerCellViewModel(id: gener.id ?? 0 , name: gener.name ?? "" )
    }

}
