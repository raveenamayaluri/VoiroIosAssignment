//
//  NetworkManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation


protocol ApiManagerprotocol {
    func getNowPlayingMoviesList( callBack: @escaping (Result<MoviesInfo,Error>) -> Void)
    func getMovieDetails(movieId:String, callBack: @escaping (Result<MovieDetails,Error>) -> Void)
}

class ApiManager: ApiManagerprotocol {
   
    func getMovieDetails(movieId:String, callBack: @escaping (Result<MovieDetails, Error>) -> Void) {
    
        let tmdbMovieDetailsUrlString = ApiConstants.TMDB_MOVIE_DETAILS_BASE_URL.replacingOccurrences(of: "MOVIE_ID", with: movieId)
        guard let requestUrl = URL(string: tmdbMovieDetailsUrlString) else {
            fatalError("Invalid Url")
        }
        let request = URLRequest(url: requestUrl)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response ,error) in
            if let error = error  {
                return callBack(.failure(error))
            } else{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data{
                    do {
                        //process data
                        let moviesDetails = try decoder.decode(MovieDetails.self, from: data)
                        callBack(.success(moviesDetails))
                        print(moviesDetails)
                        
                    }  catch  let decodeError {
                        callBack(.failure(decodeError))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getNowPlayingMoviesList( callBack: @escaping (Result<MoviesInfo,Error>) -> Void){
        guard let requestUrl = URL(string: ApiConstants.TMDB_BASE_URL) else {
            fatalError("Invalid Url")
        }
        let request = URLRequest(url: requestUrl)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response ,error) in
            if let error = error  {
                return callBack(.failure(error))
            } else{
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
}


