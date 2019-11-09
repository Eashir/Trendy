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
	
	static let baseURLPath = "https://www.googleapis.com/youtube/v3"
	static let authToken = "Basic \(authorizationKey)"
	
	case videos(String)
	case duration
	
	var method: HTTPMethod {
		switch self {
		case .videos, .duration:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .videos, .duration:
			return "/videos"
		}
	}
	
	var parameters: [String: Any] {
		switch self {
		case .videos:
			return
				[
					"path": "snippet",
					"key": "\(authorizationKey)",
					"chart": "mostPopular"
				]
			
		case .duration:
			return
				[
					"path": "contentDetails",
					"key": "\(authorizationKey)",
					"chart": "mostPopular"
				]
		}
	}
	
	public func asURLRequest() throws -> URLRequest {
		let url = try NetworkRouter.baseURLPath.asURL()
		var request = URLRequest(url: url.appendingPathComponent(path))
		
		request.httpMethod = method.rawValue
		request.setValue(NetworkRouter.authToken, forHTTPHeaderField: "Authorization")
		request.timeoutInterval = TimeInterval(10 * 1000)
		
		return try URLEncoding.default.encode(request, with: parameters)
	}
	
}
