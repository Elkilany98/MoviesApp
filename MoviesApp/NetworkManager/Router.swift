//
//  Router.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 10/09/2021.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    case nowPlayingMovies(page:String)
    case topRatedMovies(page:String)
    case searchMovie(page:String,searchText:String)
    case moviesDetails(moviesID:String)
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        
        case .nowPlayingMovies , .topRatedMovies , .searchMovie:
            return .get
        default:
            return .get
        }
    }
    
    
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .nowPlayingMovies : return "movie/now_playing"
        case .topRatedMovies:return "movie/top_rated"
        case .searchMovie :return "search/movie"
        case .moviesDetails(let moviesID): return "movie/\(moviesID)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: RequestParams? {
        switch self {
        
        case let .nowPlayingMovies(page):
            return.url([
                "api_key":Constants.apiKey,
                "language":Constants.languageKey,
                "page":page
            ])
            
        case let .topRatedMovies(page):
            return.url([
                "api_key":Constants.apiKey,
                "language":Constants.languageKey,
                "page":page
            ])
        
        case let .searchMovie(page , searchText):
        return.url([
            "api_key":Constants.apiKey,
            "language":Constants.languageKey,
            "page":page,
            "query":searchText
        ])
        case .moviesDetails(_):
            return.url([
                "api_key":Constants.apiKey,
                "language":Constants.languageKey,
            ])
               
            
            
            
    }
    
}


// MARK: - URLRequestConvertible
func asURLRequest() throws -> URLRequest {
    
    let url = try Constants.ProductionServer.baseURL.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    //        urlRequest.
    urlRequest.setValue("en", forHTTPHeaderField: HTTPHeaderField.lang.rawValue)
    urlRequest.setValue(nil, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
    
    if let parameters = parameters {
        switch parameters {
        case .body(let parameters):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
            }catch{
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            
        case .url(let parameters):
            let queryParams = parameters.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
        case .bodyAndURL(let bodyParameters, let urlParameters):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            let queryParams = urlParameters.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        print("The API Parameter is = \(parameters)")
    }
    print("urlRequest = \(String(describing: urlRequest.headers)) and component = \(String(describing: urlRequest.allHTTPHeaderFields))  , \(String(describing: urlRequest.httpMethod)), \(String(describing: urlRequest.url))  , \(String(describing: urlRequest.httpBody))" )
    
    return urlRequest
}
}


