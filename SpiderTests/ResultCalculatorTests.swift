//
//  ResultCalculatorTests.swift
//  SpiderTests
//
//  Created by Dukai Andrea on 2020. 09. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import XCTest
@testable import Spider

class ResultCalculatorTests: XCTestCase {

    let resultProvider = ResultProvider()
    let resultCalulator = ResultCalculator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewResultOnEmptyResultSetWorks() {
        resultProvider.clear(resultType: .result30)
        let ranking = resultCalulator.recordResult(5, resultType: .result30)
        
        XCTAssertEqual(ranking, ResultCalculator.Ranking.first)
        XCTAssertEqual([5], resultProvider.getResults(for: .result30))
    }
    
    func testAddNewResultOnNotEmptyResultSetWorks() {
        resultProvider.save(results: [12,5], of: .result30)
        let ranking = resultCalulator.recordResult(7, resultType: .result30)
        
        XCTAssertEqual(ranking, ResultCalculator.Ranking.second)
        XCTAssertEqual([12, 7, 5], resultProvider.getResults(for: .result30))
    }
    
    func testAddNewResultOnNotEmptyResultSet2Works() {
        resultProvider.save(results: [12,5,3], of: .result30)
        let ranking = resultCalulator.recordResult(4, resultType: .result30)
        
        XCTAssertEqual(ranking, ResultCalculator.Ranking.third)
        XCTAssertEqual([12, 5, 4], resultProvider.getResults(for: .result30))
    }
    
    func testAddNewResultOnNotEmptyResultSet3Works() {
        resultProvider.save(results: [12,5,4], of: .result30)
        let ranking = resultCalulator.recordResult(2, resultType: .result30)
        
        XCTAssertEqual(ranking, ResultCalculator.Ranking.none)
        XCTAssertEqual([12, 5, 4], resultProvider.getResults(for: .result30))
    }
    
    func testAddNewResultOnNotEmptyResultSet4Works() {
        resultProvider.save(results: [12,5,4], of: .result30)
        let ranking = resultCalulator.recordResult(14, resultType: .result30)
        
        XCTAssertEqual(ranking, ResultCalculator.Ranking.first)
        XCTAssertEqual([14, 12, 5], resultProvider.getResults(for: .result30))
    }
}
