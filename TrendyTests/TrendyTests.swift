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
	
		var videoPlaylist: VideoPlaylistView?
		var allVideos: [Video]?
	
    override func setUp() {
			videoPlaylist = VideoPlaylistView(videos: allVideos!)
    }

    override func tearDown() {
			videoPlaylist = nil
    }

    func testData() {
			Video.getAllTrendingVideos { videos in
				self.allVideos = videos
				XCTAssertNotNil(videos)
			}
    }
	
		func testVideoPLaylist() {
//			XCTAssertNotNil(videoPlaylist)
			XCTAssertNotNil(videoPlaylist?.player)

//			XCTAssertNotNil(videoPlaylist?.playerItems)
		}

}
