//
//  VideoTableViewCell.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import WebKit
import AVKit
import SDWebImage

class VideoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var thumbnailImageView: UIImageView!
	
	var currentVideo: Video?
	var videoPlayerView: VideoPlayerView?
	var tableSuperView: UIView?
	let fullscreenFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
	
	weak private var videoLikeDelegate: VideoLikeDelegate?
	
	@IBAction func likeButtonPressed(_ sender: UIButton) {
		guard let video = currentVideo else {return}
		self.videoLikeDelegate?.likeVideo(videoID: video.id)
	}
	
	override func prepareForReuse() {
		currentVideo = nil
		videoPlayerView = nil 
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
		
		let frame = thumbnailImageView.layer.frame
		let webView = WKWebView(frame: frame)

		webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(video.id)")!))
		self.contentView.addSubview(webView)
	}
	
	@objc func cellTapped() {
//		self.contentView.layoutIfNeeded()
//		guard let validPlayerView = videoPlayerView else {return}
//		validPlayerView.frame = fullscreenFrame
//		if let validPlayerLayer = validPlayerView.playerLayer {
//			validPlayerLayer.frame = fullscreenFrame
//		}
//
//		UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//			self.contentView.layoutIfNeeded()
//		})
//		let videoLauncher = VideoLauncher(view: tableSuperView!, playerView: validPlayerView)
//		videoLauncher.playerView.cancelButton.isHidden = false
//		videoLauncher.showVideoPlayer()
//		validPlayerView.playTrack()
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
