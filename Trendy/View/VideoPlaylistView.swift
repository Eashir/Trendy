//
//  VideoPlaylist.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/10/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlaylistView: UIView {
	let videos: [Video]
	let videoPlayerView = VideoPlayerView()
	
	let player = AVPlayer()
	var playerItems = [AVPlayerItem]()
	var currentTrack = 0
	
	private var token: NSKeyValueObservation?
	
	init(videos: [Video]) {
		self.videos = videos
		
		super.init(frame: .zero)
		
		initializePlayer()
		addGestureRecognizers()
	}
	
	private func initializePlayer() {
		videoPlayerView.player = player
		
		addAllVideosToPlayer()
		
	}
	
	private func addAllVideosToPlayer() {
		for video in videos {
				let asset = AVURLAsset(url: URL(string: video.url)!)
				let item = AVPlayerItem(asset: asset)
				self.playerItems.append(item)
		}
	}
	
	func pause() {
		player.pause()
	}
	
	func play() {
		player.play()
	}
	
	func previousTrack() {
		if currentTrack - 1 < 0 {
			currentTrack =  (currentTrack - 1 + playerItems.count) % playerItems.count
		} else {
			currentTrack -= 1
		}
		
		playTrack()
	}
	
	func nextTrack() {
		if currentTrack + 1 > playerItems.count {
			currentTrack = 0
		} else {
			currentTrack = (currentTrack + 1) % playerItems.count
		}
		
		playTrack()
	}
	
	func playTrack() {
		
		if playerItems.count > 0 {
			player.replaceCurrentItem(with: playerItems[currentTrack])
			player.play()
		}
	}
	
	// MARK - Gestures
	
	func addGestureRecognizers() {
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.playNextTrack))
		swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
		addGestureRecognizer(swipeLeft)
		
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.playPreviousTrack))
		swipeRight.direction = UISwipeGestureRecognizer.Direction.right
		
		addGestureRecognizer(swipeLeft)
		addGestureRecognizer(swipeRight)
	}
	
	@objc func playNextTrack() {
		nextTrack()
	}
	
	@objc func playPreviousTrack() {
		previousTrack()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

