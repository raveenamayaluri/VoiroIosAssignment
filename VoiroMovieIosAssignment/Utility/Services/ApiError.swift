//
//  ApiError.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 10/07/22.
//

import Foundation

enum ApiError: Error {
    
    // Throw when an server error
    case serverError

    // Throw when an internal error occured
    case internalError

    // Throw when json parse fails.
    case parsingError
    
    case invalidUrlError
}
