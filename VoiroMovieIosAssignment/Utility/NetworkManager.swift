//
//  NetworkManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation


protocol NetworkManagerprotocol {
    func getNowPlayingMoviesList( callBack: @escaping (Result<MoviesInfo,Error>) -> Void)
}

class NetworkManager: NetworkManagerprotocol {
    
    func getNowPlayingMoviesList( callBack: @escaping (Result<MoviesInfo,Error>) -> Void){
        guard let requestUrl = URL(string: APIConstants.TMDB_BASE_URL) else {
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


