//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Alamofire


protocol NetworkManagerProtocol {
    func getNowPlayingMoviesNetwork(page:String,completion:@escaping (AFResult<GeneralModel>)->Void)
    func getTopRatedMoviesNetwork(page:String,completion:@escaping (AFResult<GeneralModel>)->Void)
}

class  NetworkManager : NetworkManagerProtocol {
    
    func getNowPlayingMoviesNetwork(page: String, completion: @escaping (AFResult<GeneralModel>) -> Void) {
        AF.request(Router.nowPlayingMovies(page: page))
            .responseDecodable { (response: AFDataResponse<GeneralModel>) in
                completion(response.result)
                print("full Response = \(response.result)")
            }
    }
    
    func getTopRatedMoviesNetwork(page: String, completion: @escaping (AFResult<GeneralModel>) -> Void) {
        AF.request(Router.topRatedMovies(page: page))
            .responseDecodable { (response: AFDataResponse<GeneralModel>) in
                completion(response.result)
                print("full Response = \(response.result)")
            }
    }
    
    
}

