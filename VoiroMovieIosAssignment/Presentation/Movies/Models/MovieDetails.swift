//
//  MovieDetails.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 09/07/22.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbId, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let credits: Credits
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String
}

// MARK: - Credits
struct Credits: Codable {
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department, job: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
    
    enum CodingKeys: String, CodingKey {
           case iso3166_1 = "iso_3166_1"
           case name
       }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
    
    enum CodingKeys: String, CodingKey {
            case englishName
            case iso639_1 = "iso_639_1"
            case name
        }
}
