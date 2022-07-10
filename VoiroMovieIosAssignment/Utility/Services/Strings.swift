//
//  APIConstants.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

struct Strings {
    struct APIConstants {
        static let API_KEY =  "4d0b3130123d94833e1d1e1867fd2ae3"
        static let TMDB_BASE_URL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)&language=en-US&page=1"
        static let TMDB_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
        static let TMDB_MOVIE_DETAILS_BASE_URL = "https://api.themoviedb.org/3/movie/MOVIE_ID?api_key=\(API_KEY)&append_to_response=credits"
    }
}
