//
//  MoviesListInfo.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import Foundation

struct MoviesInfo:Codable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

// MARK: - Dates
struct Dates:Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Movie: Codable{
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
