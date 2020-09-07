//
//  SpiderTests.swift
//  SpiderTests
//
//  Created by Dukai Andrea on 2020. 09. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import XCTest
@testable import Spider

class ResultProviderTests: XCTestCase {

    let resultProvider = ResultProvider()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClearResultsWorks() {
        resultProvider.clear(resultType: .result30)
        let result = resultProvider.getResults(for: .result30)
        
        XCTAssertEqual(result, [])
    }
    
    func testSaveResultOnEmptyProviderWorks() {
        resultProvider.clear(resultType: .result30)
        resultProvider.save(results: [5], of: .result30)
        
        let result = resultProvider.getResults(for: .result30)
        
        XCTAssertEqual(result, [5])
    }
    
    func testSaveAdditionalResultWorks() {
        resultProvider.clear(resultType: .result30)
        resultProvider.save(results: [5], of: .result30)
        var results = resultProvider.getResults(for: .result30)
        results.insert(7, at: 0)
        resultProvider.save(results: results, of: .result30)
        
        XCTAssertEqual(resultProvider.getResults(for: .result30), [7, 5])
    }
}
