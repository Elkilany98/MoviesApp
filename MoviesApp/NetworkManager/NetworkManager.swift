//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Alamofire


protocol NetworkManagerProtocol {
    func getNowPlayingMoviesNetwork(page:String,completion:@escaping (AFResult<NowPlayingModel>)->Void)
}

class  NetworkManager : NetworkManagerProtocol {
    func getNowPlayingMoviesNetwork(page: String, completion: @escaping (AFResult<NowPlayingModel>) -> Void) {
        AF.request(Router.nowPlayingMovies(page: page))
            .responseDecodable { (response: AFDataResponse<NowPlayingModel>) in
                completion(response.result)
                print("full Response = \(response.result)")
            }
    }
}

