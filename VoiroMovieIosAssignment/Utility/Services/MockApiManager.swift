//
//  MockNetworkManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation

class MockApiManager: ApiManagerprotocol {
    
    func getNowPlayingMoviesList(callBack: @escaping (Result<MoviesInfo, Error>) -> Void) {
        callBack(.success(getMovieInfo()))
    }
    
    func getMovieDetails(movieId: String, callBack: @escaping (Result<MovieDetails, Error>) -> Void) {
        
    }
    
    private func getMovieInfo()-> MoviesInfo {
        let dates = Dates(maximum: "2022-07-13", minimum: "2022-05-26")
        
        let movie1 = Movie(adult: false, backdropPath: "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg", genreIds: [14, 28, 12], id: 453395, originalLanguage: "en", originalTitle: "Doctor Strange in the Multiverse of Madness", overview: "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.", popularity: 6647.226, posterPath: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", releaseDate: "2022-05-04", title: "Doctor Strange in the Multiverse of Madness", video: false, voteAverage: 7.5, voteCount: 4067)
        
        let movie2 = Movie(adult: false, backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg", genreIds: [10751, 16, 12, 35], id: 438148, originalLanguage: "en", originalTitle: "Minions: The Rise of Gru", overview: "A fanboy of a supervillain supergroup known as the Vicious 6, Gru hatches a plan to become evil enough to join them, with the backup of his followers, the Minions.", popularity: 4115.543, posterPath: "/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg", releaseDate: "2022-06-29", title: "Minions: The Rise of Gru", video: false, voteAverage: 7.9, voteCount: 143)
    
        let movieInfo = MoviesInfo(dates: dates, page: 1, results: [movie1,movie2], totalPages: 67, totalResults: 1340)
        return movieInfo
    }
    
}
