//
//  MovieListViewModelTests.swift
//  VoiroMovieIosAssignmentTests
//
//  Created by Raveena on 10/07/22.
//

import XCTest
@testable import VoiroMovieIosAssignment

class MovieListViewModelTests: XCTestCase {

    var mockAPIService : ApiManagerprotocol!
    var sut : MovieListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockApiManager()
        sut = MovieListViewModel(apiService: mockAPIService)
    }
    
    func testMoviesListFetchSuccess() {
        XCTAssertNotNil(sut.getMoviesList())
        
        //Arrange
        sut.getNowPlayingMoviesList()
        
        let nowPlayingMovies = sut.getMoviesList()
        
        XCTAssert(nowPlayingMovies.count > 0)
        
        let movie = nowPlayingMovies.first
        
        XCTAssertNotNil(movie)
        
        let expectedMovie = Movie(adult: false, backdropPath: "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg", genreIds: [14, 28, 12], id: 453395, originalLanguage: "en", originalTitle: "Doctor Strange in the Multiverse of Madness", overview: "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.", popularity: 6647.226, posterPath: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", releaseDate: "2022-05-04", title: "Doctor Strange in the Multiverse of Madness", video: false, voteAverage: 7.5, voteCount: 4067)
        
        XCTAssertEqual(movie, expectedMovie)
    }
    
    func testMoviesListFilterWithEmptyText() {
        sut.getNowPlayingMoviesList()
        let movies = sut.getMoviesList()
        sut.filteredMovies("")
        let filteredMovies = sut.getMoviesList()
        XCTAssertEqual(movies.count, filteredMovies.count)
    }
    
    func testMoviesListFilterWithMatchText() {
        sut.getNowPlayingMoviesList()
        sut.filteredMovies("Doctor")
        let expectedValue = 1
        
        let filteredMovies = sut.getMoviesList()
        XCTAssertEqual(filteredMovies.count, expectedValue)
    }
    
    func testMoviesListFilterWithNotMatchText() {
        sut.getNowPlayingMoviesList()
        sut.filteredMovies("XYXYX")
        let expectedValue = 0
        
        let filteredMovies = sut.getMoviesList()
        XCTAssertEqual(filteredMovies.count, expectedValue)
    }
}
