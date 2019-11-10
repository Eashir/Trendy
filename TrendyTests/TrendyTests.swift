//
//  TrendyTests.swift
//  TrendyTests
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import XCTest
@testable import Trendy

class TrendyTests: XCTestCase {
	
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
	
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
			Video.getAllTrendingVideos { videos in
				XCTAssertNotNil(videos)
			}
    }
	
		func testVideoTitle() {
			
				
		}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
