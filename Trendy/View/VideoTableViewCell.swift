//
//  VideoTableViewCell.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import SDWebImage

class VideoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var thumbnailImageView: UIImageView!
	
	var currentVideo: Video?
	
	weak private var videoLikeDelegate: VideoLikeDelegate?
	
	@IBAction func likeButtonPressed(_ sender: UIButton) {
		guard let video = currentVideo else {return}
		self.videoLikeDelegate?.likeVideo(videoID: video.id)
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
		
		guard let validDurationStr = video.duration.getDurationStrFromIso8601() else {return}
		durationLabel.text = validDurationStr
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
		
		//SDWebImage to handle efficient, speedy image load+caching
		thumbnailImageView.sd_setImage(with: validVideo.thumbnailURL)
		
		let isAlreadyLiked = Defaults.exists(key: validVideo.id)
		switch isAlreadyLiked {
		case true:
			videoLikeDelegate?.likeNewVideo(validVideo.id)
		case false:
			videoLikeDelegate?.removeLikedVideo(validVideo.id)
		}
	}
	
}
