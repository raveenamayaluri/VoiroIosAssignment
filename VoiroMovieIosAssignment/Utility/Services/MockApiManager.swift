//
//  MockApiManager.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation

class MockApiManager: ApiManagerprotocol {
    
    func getNowPlayingMoviesList(completion: @escaping (Result<MoviesInfo, ApiError>) -> Void) {
        completion(.success(getMovieInfo()))
    }
    
    func getMovieDetails(movieId: String, completion: @escaping (Result<MovieDetail, ApiError>) -> Void) {
        completion(.success(getMovieDetails()))
    }
    
    private func getMovieInfo()-> MoviesInfo {
        let dates = Dates(maximum: "2022-07-13", minimum: "2022-05-26")
        
        let movie1 = Movie(adult: false, backdropPath: "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg", genreIds: [14, 28, 12], id: 453395, originalLanguage: "en", originalTitle: "Doctor Strange in the Multiverse of Madness", overview: "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.", popularity: 6647.226, posterPath: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", releaseDate: "2022-05-04", title: "Doctor Strange in the Multiverse of Madness", video: false, voteAverage: 7.5, voteCount: 4067)
        
        let movie2 = Movie(adult: false, backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg", genreIds: [10751, 16, 12, 35], id: 438148, originalLanguage: "en", originalTitle: "Minions: The Rise of Gru", overview: "A fanboy of a supervillain supergroup known as the Vicious 6, Gru hatches a plan to become evil enough to join them, with the backup of his followers, the Minions.", popularity: 4115.543, posterPath: "/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg", releaseDate: "2022-06-29", title: "Minions: The Rise of Gru", video: false, voteAverage: 7.9, voteCount: 143)
    
        let movieInfo = MoviesInfo(dates: dates, page: 1, results: [movie1,movie2], totalPages: 67, totalResults: 1340)
        return movieInfo
    }
    
    private func getMovieDetails() -> MovieDetail {
        
        let geners = [Genre(id: 14, name: "Fantasy"),Genre(id: 28, name: "Action"),Genre(id: 12, name: "Adventure")]
        
        let spokenLanguages = [SpokenLanguage(englishName: "Cantonese", iso639_1: "cn", name: "广州话 / 廣州話"), SpokenLanguage(englishName: "English", iso639_1: "en", name: "English"), SpokenLanguage(englishName: "Spanish", iso639_1: "es", name: "Español")]
        
        let casts = [Cast(adult: false, gender: 2, id: 71580, knownForDepartment: "Acting", name: "Benedict Cumberbatch", originalName: "Benedict Cumberbatch", popularity: 63.465, profilePath: "/fBEucxECxGLKVHBznO0qHtCGiMO.jpg", castID: 2, character: "Dr. Stephen Strange / Sinister Strange / Defender Strange", creditID: "58fa84bbc3a36879f40021db", order: 0, department: nil, job: nil)]
        
        let credits = Credits(cast: casts, crew: casts)
        
        let movieDetails = MovieDetail(adult: false, backdropPath: "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg", belongsToCollection: nil, budget: 618529, genres: geners, homepage: "https://www.marvel.com/movies/doctor-strange-in-the-multiverse-of-madness", id: 453395, imdbId: "tt9419884", originalLanguage: "en", originalTitle: "Doctor Strange in the Multiverse of Madness", overview:  "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.", popularity: 6388.561, posterPath: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", productionCompanies: nil, productionCountries: nil, releaseDate: "2022-05-04", revenue: 953200000, runtime: 126, spokenLanguages: spokenLanguages, status: "Released", tagline: "Enter a new dimension of Strange.", title: "Doctor Strange in the Multiverse of Madness", video: false, voteAverage: 7.5, voteCount: 4176, credits: credits)
        
        return movieDetails
    }
    
}
