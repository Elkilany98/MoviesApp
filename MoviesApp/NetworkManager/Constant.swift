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
        static let baseURL = "https://www.shattoor.com/api/api/"
    }
    
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

