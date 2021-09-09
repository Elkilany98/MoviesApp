//
//  Constant.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//
import Foundation
import Alamofire

struct Constants {
    
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
    }
    
    static let apiKey = "0d77ea0a9efc3d9d4a2d759ca0820201"
    static let languageKey = "en-US"
    static  let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZDc3ZWEwYTllZmMzZDlkNGEyZDc1OWNhMDgyMDIwMSIsInN1YiI6IjYxM2E4YTNhZGQ3MzFiMDA0MzNjNDYxNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ipvQN2R1sa97Fxiw9uhN6BvzyKqv4e8OkmjNA7rxAOY"
    
    enum InternetConnection :String {
        case noInternet = "Internet Connection Faild"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case lang = "lang"
}

enum ContentType: String {
    case json = "application/json"
    case deviceType = "ios"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
    case bodyAndURL(body:Parameters , url:Parameters)
}

