//
//  MovieRequester.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 05/08/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias callback = ((ResponseWrapper<Any>) -> Void)

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct ResponseWrapper<T> {
    var result: Result<T>
}

class MovieRequesterData {
    static let shared = MovieRequesterData()
    
    struct EnviromentData {
        let host: String
        let client_id: String
    }
    
    var enviroment: EnviromentData {
        return EnviromentData(host: "https://api.themoviedb.org/3/discover/movie?", client_id: "api_key=e6553556340347692783dc9baa492dd2&")
    }
}

class BaseRequester {
    static let shared = BaseRequester()
    
    func baseRequest(path: String, httpMethod: HTTPMethod, completion: @escaping callback) {
        if let pathRequest = URL(string: "\(MovieRequesterData.shared.enviroment.host)\(MovieRequesterData.shared.enviroment.client_id)") {
            Alamofire.request(pathRequest, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    let wrapper = ResponseWrapper<Any>(result: Result.failure(error))
                    completion(wrapper)
                case .success(let data):
                    let wrapper = ResponseWrapper<Any>(result: Result.success(data))
                    completion(wrapper)
                }
            }
        }
    }
}

class MovieRequester {
    func getPopularMovies(completion: @escaping (Result<[Movie]>) -> Void) {
        let path = "sort_by=popularity.desc"
        BaseRequester.shared.baseRequest(path: path, httpMethod: .get) { (response) in
            switch response.result {
            case .success(let data):
                let movieJSON = JSON(data)
                let movies = movieJSON["results"].arrayValue.compactMap { Movie.init(withJSON: $0) }
                DispatchQueue.main.async {
                    completion(Result.success(movies))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
        }
    }
}
