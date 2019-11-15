//
//  NetworkRouter.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import Alamofire

let authorizationKey = "AIzaSyDojb18z2TMWfVBcvhKa8cdfeumGXdahwM"

public enum NetworkRouter: URLRequestConvertible {
	
	//Opted for single networking class to handle multiple GET, POST, PATCH for data retrieval + a real like system
	static let baseURLPath = "https://www.googleapis.com/youtube/v3"
	
	case videos
	
	var method: HTTPMethod {
		switch self {
		case .videos:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .videos:
			return "/videos"
		}
	}
	
	var parameters: [String: Any] {
		switch self {
		case .videos:
			return
				[
					"part": "snippet, contentDetails",
					"key": "\(authorizationKey)",
					"chart": "mostPopular",
					"maxResults": "10"
				]
		}
	}
	
	public func asURLRequest() throws -> URLRequest {
		let url = try NetworkRouter.baseURLPath.asURL()
		var request = URLRequest(url: url.appendingPathComponent(path))
		
		request.httpMethod = method.rawValue
		request.timeoutInterval = TimeInterval(10 * 1000)
		
		return try URLEncoding.default.encode(request, with: parameters)
	}
	
}
