//
//  ServiceTest.swift
//  TheMovieDBAppTests
//
//  Created by Fandrian Rhamadiansyah on 19/12/20.
//

import XCTest
@testable import TheMovieDBApp

class ServiceTest: XCTestCase {
    
    var service = APIService()
    var homeVM = HomeViewModel()
    var detailVM = MovieDetailViewModel()
    var expectation: XCTestExpectation?
    
    let dummyMovie = MovieDetail(id: 765123, title: "Christmas Crossfire", overview: "ASDA", release:  "2020-12-04", image: "/ajKpYK7XdzIYjy9Uy8nkgRboKyv.jpg", rating: 5.0, ratingCount: 23)
    
    func testRequestAPI() throws {
        
        service.fetchURL { (res) in
            XCTAssertNotNil(self.service.forTestData)
        }

    }
    
    
    func testRequestFromViewModel() throws {
        
        homeVM.fetchURL { (res) in
            XCTAssert(!res.isEmpty)
        }

    }
    
    func testFetchComment() throws {
        
        detailVM.selectedMovie = dummyMovie
        
        detailVM.fetchComment { (comment) in
            XCTAssert(!comment.isEmpty)
        }

    }
    
    
    func testWriteToCoreData() throws {
        
        homeVM.fetchURL { (res) in
            XCTAssert(!res.isEmpty)
        }

    }

    

}
