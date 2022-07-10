//
//  NetworkManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation

protocol ApiManagerprotocol {
    func getNowPlayingMoviesList(completion: @escaping (Result<MoviesInfo,ApiError>) -> Void)
    func getMovieDetails(movieId:String, completion: @escaping (Result<MovieDetail,ApiError>) -> Void)
}

class ApiManager: ApiManagerprotocol {
  
    func getNowPlayingMoviesList(completion: @escaping (Result<MoviesInfo, ApiError>) -> Void) {
        guard let requestUrl = URL(string: Strings.APIConstants.TMDB_BASE_URL) else {
            completion(.failure(.invalidUrlError))
            return
        }
        
        request(url: requestUrl, method: "GET", completion: completion)
    }
    
    func getMovieDetails(movieId:String, completion: @escaping (Result<MovieDetail, ApiError>) -> Void) {
        let tmdbMovieDetailsUrlString = Strings.APIConstants.TMDB_MOVIE_DETAILS_BASE_URL.replacingOccurrences(of: "MOVIE_ID", with: movieId)
        guard let requestUrl = URL(string: tmdbMovieDetailsUrlString) else {
            completion(.failure(.invalidUrlError))
            return
        }
        
        request(url: requestUrl, method: "GET", completion: completion)
    }
    
    
    private func request<T:Decodable>(url:URL, method:String, completion: @escaping (Result<T,ApiError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response ,error) in
            
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.serverError))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                //process data
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
                
            } catch  {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}


