//
//  MovieDetailViewModelTests.swift
//  VoiroMovieIosAssignmentTests
//
//  Created by Raveena on 10/07/22.
//

import XCTest
@testable import VoiroMovieIosAssignment

class MovieDetailViewModelTests: XCTestCase {

    var mockAPIService : ApiManagerprotocol!
    var sut : MovieDetailViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockApiManager()
        sut = MovieDetailViewModel(apiService: mockAPIService)
    }

    
    func testMovieDetailFetchSuccess() {
        XCTAssertNil(sut.getSelectedMovieDetail())
        
        //Arrange
        let movieId = 71580
        sut.getMovieDetails(movieId: movieId)
        
        let expectedValue = sut.getSelectedMovieDetail()
        XCTAssertNotNil(expectedValue)
        XCTAssertNotNil(expectedValue?.title)
    }
    
    func testGetMovieRunTimeWithHourAndMinuteText() {
        let expectedValue = "1 hour 1 min"
        
        let runTime = 61
        XCTAssertEqual(sut.getMovieRunTime(runTime: runTime), expectedValue)
    }
    
    func testGetMovieRunTimeWithHours() {
        let expectedValue = "2 hours 30 mins"
        
        let runTime = 150
        XCTAssertEqual(sut.getMovieRunTime(runTime: runTime), expectedValue)
    }
    func testGetFormattedDateFromString(){
        let expectedValue = "May 04, 2022"
        
        let releaseDate =  "2022-05-04"
        XCTAssertEqual(sut.getFormattedDateFromString(dateString: releaseDate), expectedValue)
    }
    
    func testGetMovieLanguages() {
        let expectedValue = "Cantonese, English, Spanish"
        
        let spokenLanguages = [SpokenLanguage(englishName: "Cantonese", iso639_1: "cn", name: "广州话 / 廣州話"), SpokenLanguage(englishName: "English", iso639_1: "en", name: "English"), SpokenLanguage(englishName: "Spanish", iso639_1: "es", name: "Español")]
        
        XCTAssertEqual(sut.getMovieLanguages(spokenLanguages: spokenLanguages), expectedValue)
    }
    
    
    func testGetMovieGeneres() {
        let expectedValue = "Fantasy, Action, Adventure"
        
        let geners = [Genre(id: 14, name: "Fantasy"),Genre(id: 28, name: "Action"),Genre(id: 12, name: "Adventure")]
        
        XCTAssertEqual(sut.getMovieGenres(genres: geners), expectedValue)
    }
    
    func testGetMovieCast() {
        
        let expectedValue = "Charecter Name 1 (Original Name 1),\nCharecter Name 2 (Original Name 2)"
        
        let casts = [
            Cast(adult: false, gender: 2, id: 71580, knownForDepartment: "Acting", name: "Benedict Cumberbatch", originalName: "Original Name 1", popularity: 63.465, profilePath: "/fBEucxECxGLKVHBznO0qHtCGiMO.jpg", castID: 2, character: "Charecter Name 1", creditID: "58fa84bbc3a36879f40021db", order: 0, department: nil, job: nil),
            Cast(adult: false, gender: 2, id: 71580, knownForDepartment: "Acting", name: "Benedict Cumberbatch", originalName: "Original Name 2", popularity: 63.465, profilePath: "/fBEucxECxGLKVHBznO0qHtCGiMO.jpg", castID: 2, character: "Charecter Name 2", creditID: "58fa84bbc3a36879f40021db", order: 0, department: nil, job: nil)
        ]
        
        XCTAssertEqual(sut.getMovieCasts(cast: casts), expectedValue)
    }
}
