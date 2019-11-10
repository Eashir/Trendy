//
//  VideoLikeDelegate.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

protocol VideoLikeDelegate: class {
	
	func newVideoLiked(success: Bool)
	func removedLike(success: Bool)
	
}

extension VideoLikeDelegate {
	
	internal func likeVideo(videoID: String) {
		let isAlreadyLiked = Defaults.exists(key: videoID)
		switch isAlreadyLiked {
		case true:
			removeLikedVideo(videoID)
		case false:
			likeNewVideo(videoID)
		}
	}
	
	internal func removeLikedVideo(_ videoID: String) {
		Defaults.remove(videoID)
		removedLike(success: true)
	}
	
	internal func likeNewVideo(_ videoID: String) {
		Defaults.save(videoID)
		newVideoLiked(success: true)
	}
	
}

