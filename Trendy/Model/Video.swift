//
//  Video.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import Alamofire

struct ListResponse: Decodable {
	let kind: String
	let etag: String
	let nextPageToken: String
	
	let items: [Video]
}

class Video: Decodable {
	
	let title: String
	let duration: String
	let id: String
	let url: String
	let thumbnailURL: URL
	
	enum CodingKeys: String, CodingKey {
		case items = "items"
		case id = "id"
		case snippet = "snippet"
		case thumbnails = "thumbnails"
		case defaul = "default"
		case title = "title"
		case thumbnailURL = "url"
		case contentDetails = "contentDetails"
		case duration = "duration"
	}

	required init(from decoder: Decoder) throws {
		let itemDict = try decoder.container(keyedBy: CodingKeys.self)
		id = try itemDict.decode(String.self, forKey: .id)
		url = "youtube.com//watch?v=\(id)"
		let contentDetails = try itemDict.nestedContainer(keyedBy: CodingKeys.self, forKey: .contentDetails)
		duration = try contentDetails.decode(String.self, forKey: .duration)
		let snippet = try itemDict.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
		title = try snippet.decode(String.self, forKey: .title)
		let thumbnails = try snippet.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
		let defaul = try thumbnails.nestedContainer(keyedBy: CodingKeys.self, forKey: .defaul)
		thumbnailURL = try defaul.decode(URL.self, forKey: .thumbnailURL)
	}
	
	class func getAllTrendingVideos( completion: @escaping ([Video] ) -> Void) {
		
		Alamofire.request(NetworkRouter.videos).responseData { (response) in
			
			do {
				let decoder = JSONDecoder()
				let video = try decoder.decode(ListResponse.self, from: response.result.value!) //Decode JSON Response Data
				
				print(video)
				completion(video.items)
			} catch let parsingError {
				print("Error", parsingError)
			}

		}
	}
	

}
