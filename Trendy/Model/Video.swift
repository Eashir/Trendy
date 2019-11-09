//
//  Video.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class Video: Codable {
	
	let title: String
	let duration: String
	let id: String
	let url: URL
	let thumbnailURL: URL
	
	init(title: String, duration: String, id: String, url: URL, thumbnailURL: URL) {
		self.title = title
		self.duration = duration
		self.id = id
		self.url = url
		self.thumbnailURL = thumbnailURL
	}
	
}
