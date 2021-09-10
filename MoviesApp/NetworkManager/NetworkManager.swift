//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Alamofire


protocol NetworkManagerProtocol {
    func getNowPlayingMoviesNetwork(page:String,completion:@escaping (AFResult<NowPlayingModel>)->Void)
    func getTopRatedMoviesNetwork(page:String,completion:@escaping (AFResult<TopRatedModel>)->Void)
}

class  NetworkManager : NetworkManagerProtocol {
    
    func getNowPlayingMoviesNetwork(page: String, completion: @escaping (AFResult<NowPlayingModel>) -> Void) {
        AF.request(Router.nowPlayingMovies(page: page))
            .responseDecodable { (response: AFDataResponse<NowPlayingModel>) in
                completion(response.result)
                print("full Response = \(response.result)")
            }
    }
    
    func getTopRatedMoviesNetwork(page: String, completion: @escaping (AFResult<TopRatedModel>) -> Void) {
        AF.request(Router.topRatedMovies(page: page))
            .responseDecodable { (response: AFDataResponse<TopRatedModel>) in
                completion(response.result)
                print("full Response = \(response.result)")
            }
    }
    
    
}

