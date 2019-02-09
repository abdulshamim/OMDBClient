//
//  OMDBClientTests.swift
//  OMDBClientTests
//
//  Created by Abdul Shamim on 07/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import XCTest
@testable import OMDBClient

class OMDBClientTests: XCTestCase {

    let moviesCollectionController = MoviesCollectionController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPresenter() {
        let presenter = moviesCollectionController.presenter
        XCTAssert(presenter == nil, "Presenter should not be nil.")
    }
    
    func testMoviesGettingFromServer() {
        let presenter = moviesCollectionController.presenter
        presenter?.getMovies(pageCount: 1) {(isSuccess: Bool) in
            XCTAssertTrue(isSuccess, "No movies found")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
