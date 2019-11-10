//
//  VideoTableViewCell.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var likeButton: UIButton!
	
	var currentVideo: Video?
	weak private var videoLikeDelegate: VideoLikeDelegate?
	
	@IBAction func likeButtonPressed(_ sender: UIButton) {
		guard let video = currentVideo else {return}
		videoLikeDelegate?.likeVideo(videoID: video.id)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		videoLikeDelegate = self
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupCellLayersAndImage()
	}
	
	func setupCell(video: Video) {
		currentVideo = video
		
		titleLabel.text = video.title
	}
	
}

extension VideoTableViewCell: VideoLikeDelegate {
	
	func newVideoLiked(success: Bool) {
		if success {
			likeButton.setImage(UIImage(named: "likeImageFilled"), for: .normal)
		}
	}
	
	func removedLike(success: Bool) {
		if success {
			likeButton.setImage(UIImage(named: "likeImageUnfilled"), for: .normal)
		}
	}
	
}

extension VideoTableViewCell {
	
	func setupCellLayersAndImage() {
		guard let validVideo = currentVideo else {return}

		let isAlreadyLiked = Defaults.exists(key: validVideo.id)
		switch isAlreadyLiked {
		case true:
			videoLikeDelegate?.likeNewVideo(validVideo.id)
		case false:
			videoLikeDelegate?.removeLikedVideo(validVideo.id)
		}
	}
	
}
