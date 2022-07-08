//
//  NetworkManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation
private let API_KEY =  "4d0b3130123d94833e1d1e1867fd2ae3"
private let TMDB_BASE_URL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)&language=en-US&page=1"

func getMoviesList( callBack: @escaping (Result<MoviesInfo,Error>) -> Void){
    guard let requestUrl = URL(string: TMDB_BASE_URL) else {
        fatalError("Invalid Url")
    }
    let request = URLRequest(url: requestUrl)
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response ,error) in
        if let error = error  {
            return callBack(.failure(error))
        }else{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data{
                do {
                    //process data
                    let moviesInfo = try decoder.decode(MoviesInfo.self, from: data)
                    callBack(.success(moviesInfo))
                    print(moviesInfo)
                }  catch  let decodeError {
                    callBack(.failure(decodeError))
                }
            }
        }
}
    dataTask.resume()
}

