//
//  MoviesLIstModel.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation

protocol MovieViewModelProtocol {
    func didRecieveMovieInfo(movieInfo: MoviesInfo)
    func didRecieveError(message: String)
}

class MoviesListViewModel {
    
    var delegate: MovieViewModelProtocol?
    let apiService: ApiManagerprotocol
    
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    init(apiService:ApiManagerprotocol = ApiManager()){
        self.apiService = apiService
    }
    
    func filteredMovies (_ searchText: String) {
        filteredMovies = searchText.isEmpty ? movies : movies.filter({$0.originalTitle.localizedCaseInsensitiveContains(searchText)})
    }
    
    func getNowPlayingMoviesList(){
        if Reachability.isConnectedToNetwork(){
            apiService.getNowPlayingMoviesList(){ [weak self] result in
                switch result {
                case .success(let moviesInfo):
                    self?.movies = moviesInfo.results
                    self?.filteredMovies =  moviesInfo.results
                    self?.delegate?.didRecieveMovieInfo(movieInfo: moviesInfo)
                case .failure(let error):
                    print(error)
                    self?.delegate?.didRecieveError(message: "Unable to fetch data")
                }
            }
        }else{
            print("Internet Connection not Available!")
        }
        
    }
    
    func getMoviesList () -> [Movie] {
        return filteredMovies
    }
}
