//
//  MovieInfoViewModel.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 09/07/22.
//

import Foundation
protocol MovieInfoViewModelProtocol {
    func didRecieveMovieInfo(movieDetails: MovieDetails)
    func didRecieveError(message: String)
}

class MovieInfoViewModel {
    var delegate: MovieInfoViewModelProtocol?
    let apiService: ApiManagerprotocol
    private var movieDetails:MovieDetails?
    
    init(apiService:ApiManagerprotocol = ApiManager()){
        self.apiService = apiService
    }
    
    func getMovieDetails(movieId:Int){
        if Reachability.isConnectedToNetwork(){
            apiService.getMovieDetails(movieId: String(movieId)) { [weak self] result in
                switch result{
                case .success(let movieDetails):
                    self?.movieDetails = movieDetails
                    self?.delegate?.didRecieveMovieInfo(movieDetails: movieDetails)
                case .failure(let error):
                    print(error)
                    self?.delegate?.didRecieveError(message: "Unable to fetch data")
                }
            }
        }else{
            print("Internet Not Available")
        }
        
        
    }
    func getMovieRunTime(runTime:Int) -> String{
        let hours = runTime / 60
        let minutes = runTime-hours*60
        let hourText = hours < 2 ? "hour" : "hours"
        let minuteText = minutes < 2 ? "min" : "mins"
        return "\(hours) \(hourText) \(minutes)\(minuteText)"
        
    }
    
    func getMovieLanguages(spokenLanguages: [SpokenLanguage]) -> String {
        let languages = spokenLanguages.compactMap({ $0.englishName})
        return languages.joined(separator: ",")
    }
    
    func getMovieGenres(genres: [Genre]) -> String {
        return genres
            .compactMap({ $0.name})
            .joined(separator: ",")
    }
    
    func getMovieCasts (cast: [Cast]) -> String {
        return cast.compactMap { cast in
            let charecter = cast.character ?? ""
            return "\(charecter) (\(cast.originalName))"
        }.joined(separator: ",\n")
    }
}

