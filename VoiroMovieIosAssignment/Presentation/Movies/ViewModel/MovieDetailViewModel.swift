//
//  MovieDetailViewModel.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 09/07/22.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    func didRecieveMovies()
    func didRecieveError(message: String)
}

class MovieDetailViewModel {
    
    var delegate: MovieDetailViewModelProtocol?
    let apiService: ApiManagerprotocol
    private var movieDetail:MovieDetail?
    
    init(apiService:ApiManagerprotocol = ApiManager()){
        self.apiService = apiService
    }
    
    func getMovieDetails(movieId:Int){
        if Reachability.isConnectedToNetwork(){
            apiService.getMovieDetails(movieId: String(movieId)) { [weak self] result in
                switch result{
                case .success(let movieDetails):
                    self?.movieDetail = movieDetails
                    self?.delegate?.didRecieveMovies()
                case .failure(let error):
                    self?.delegate?.didRecieveError(message: "Unable to fetch data")
                }
            }
        }else{
            delegate?.didRecieveError(message: "No Internet Connection")
        }
    }
    
    func getSelectedMovieDetail() -> MovieDetail? {
        return movieDetail
    }
    
    func getMovieRunTime(runTime:Int) -> String{
        let hours = runTime / 60
        let minutes = runTime-hours*60
        let hourText = hours < 2 ? "hour" : "hours"
        let minuteText = minutes < 2 ? "min" : "mins"
        return "\(hours) \(hourText) \(minutes) \(minuteText)"
        
    }
    func getFormattedDateFromString(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy"
            return outputFormatter.string(from: date)
        }
        return dateString
    }
    func getMovieLanguages(spokenLanguages: [SpokenLanguage]) -> String {
        let languages = spokenLanguages.compactMap({ $0.englishName})
        return languages.joined(separator: ", ")
    }
    
    func getMovieGenres(genres: [Genre]) -> String {
        return genres
            .compactMap({ $0.name})
            .joined(separator: ", ")
    }
    
    func getMovieCasts (cast: [Cast]) -> String {
        return cast.compactMap { cast in
            let charecter = cast.character ?? ""
            return "\(charecter) (\(cast.originalName))"
        }.joined(separator: ",\n")
    }
}

