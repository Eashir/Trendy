//
//  VideoLikeDelegate.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

protocol VideoLikeDelegate: class {
	
	func videoLiked(success: Bool)
	func removedLike(success: Bool)
	
}

extension VideoLikeDelegate where Self: UIViewController {
	
	internal func likeVideo(_ videoID: String) {
		let isAlreadyLiked = Defaults.checkIfKeyExists(videoID)
		switch isAlreadyLiked {
		case true:
			removeLikedVideo(videoID)
		case false:
			Defaults.save(videoID)
		}
		
	}
	
	internal func removeLikedVideo(_ videoID: String) {
		Defaults.remove(videoID)
	}
	
}

