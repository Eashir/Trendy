//
//  VideoPlaylistLauncher.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/11/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
	
	init(videos: [Video], frame: CGRect) {
		self.videos = videos
		super.init(frame: frame)
		
		setupGradientLayer()
		
		setupPlayerView()
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Properties
	
	var player: AVPlayer?
	var playerLayer: AVPlayerLayer?
	var playerItems = [AVPlayerItem]()
	var currentTrack = 0
	var videos: [Video]
	var isPlaying = false
	
	lazy var pausePlayButton: UIButton = {
		let button = UIButton(type: .system)
		let image = UIImage(named: "pause")
		button.setImage(image, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = .white
		button.isHidden = true
		button.addTarget(self, action: #selector(pausePressed), for: .touchUpInside)
		return button
	}()
	
	lazy var cancelButton: UIButton = {
		let button = UIButton(type: .system)
		let image = UIImage(named: "cancel")
		button.setImage(image, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = .white
		button.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
		return button
	}()
	
	let currentTimeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "00:00"
		label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 13)
		return label
	}()
	
	let videoLengthLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "00:00"
		label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.textAlignment = .right
		return label
	}()
	
	let controlsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0, alpha: 1)
		return view
	}()
	
	// MARK: - Setup
	
	private func setupPlayerView() {
		addGestureRecognizers()
		addAllVideosToPlayer()
	}
	
	private func setupGradientLayer() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
		gradientLayer.locations = [0.7, 1.2]
		controlsContainerView.layer.addSublayer(gradientLayer)
	}
	
	func setupViews() {
		if let validStatusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
			validStatusBar.isHidden = true
		}
		
		controlsContainerView.frame = frame
		addSubview(controlsContainerView)
	
		controlsContainerView.addSubview(pausePlayButton)
		pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
		pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		controlsContainerView.addSubview(cancelButton)
		cancelButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		cancelButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
		cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		cancelButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		controlsContainerView.addSubview(videoLengthLabel)
		videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
		videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		controlsContainerView.addSubview(currentTimeLabel)
		currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
		currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
		currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		backgroundColor = .black
	}
	
	private func addAllVideosToPlayer() {
		
		//Add first cell video
		if let url = URL(string: videos[0].url) {
			player = AVPlayer(url: url)
			let asset = AVURLAsset(url: url)
			loadPropertyValues(forAsset: asset)
		}
		
		//Add rest of the videos
//		if videos.count > 1 {
//			for i in 1...videos.count - 1 {
//				guard let validURL = URL(string: videos[i].url) else {
//					continue
//				}
//				let asset = AVURLAsset(url: validURL)
//				loadPropertyValues(forAsset: asset)
//			}
//
//		}
	}
	
	func hideUIForCell() {
		self.player?.isMuted = true
		self.pausePlayButton.isHidden = true
		self.currentTimeLabel.isHidden = true
		self.videoLengthLabel.isHidden = true
		self.cancelButton.isHidden = true
	}
	
//	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//	
//		if keyPath == "currentItem.loadedTimeRanges" {
//			controlsContainerView.backgroundColor = .clear
//			pausePlayButton.isHidden = false
//			isPlaying = true
//
//			let duration = playerItems[currentTrack].duration
//			let seconds = CMTimeGetSeconds(duration)
//			if seconds > 0 {
//				let secondsText = Int(seconds) % 60
//				let minutesText = String(format: "%02d", Int(seconds) / 60)
//				videoLengthLabel.text = "\(minutesText):\(secondsText)"
//			}
//		}
//		
//	}
	
	// MARK: - Asset Property Handling
	
	func loadPropertyValues(forAsset newAsset: AVURLAsset) {
		
		let assetKeysRequiredToPlay = [
			"playable",
			"hasProtectedContent"
		]
		
		newAsset.loadValuesAsynchronously(forKeys: assetKeysRequiredToPlay) {
			DispatchQueue.main.async { 
				if self.validateValues(forKeys: assetKeysRequiredToPlay, forAsset: newAsset) {
					let item = AVPlayerItem(asset: newAsset)
					self.playerItems.append(item)
					self.playerLayer = AVPlayerLayer(player: self.player)
					self.layer.addSublayer(self.playerLayer!)
					self.playerLayer!.frame = self.frame
					self.playTrack()
				}
			}
		}
		
	}
	
	func validateValues(forKeys keys: [String], forAsset newAsset: AVAsset) -> Bool {
		for key in keys {
			var error: NSError?
			if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
				let stringFormat = NSLocalizedString("The media failed to load the key \"%@\"",
																						 comment: "You can't use this AVAsset because one of it's keys failed to load.")
				
				let message = String.localizedStringWithFormat(stringFormat, key)
				self.handleErrorWithMessage(message, error: error)
				
				return false
			}
		}
		
		if !newAsset.isPlayable || newAsset.hasProtectedContent {
			let message = NSLocalizedString("The media isn't playable or it contains protected content.",
																			comment: "You can't use this AVAsset because it isn't playable or it contains protected content.")
			self.handleErrorWithMessage(message)
			return false
		}
		
		return true
	}
	
	func handleErrorWithMessage(_ message: String, error: Error? = nil) {
		if let err = error {
			print("Error occurred with message: \(message), error: \(err).")
		}
		let alertTitle = NSLocalizedString("Error", comment: "Alert title for errors")
		
		let alert = UIAlertController(title: alertTitle, message: message,
																	preferredStyle: UIAlertController.Style.alert)
		let alertActionTitle = NSLocalizedString("OK", comment: "OK on error alert")
		let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
		alert.addAction(alertAction)
	}
	
	// MARK: - Playlist System

	func playTrack() {
		if playerItems.count > 0 {
			player!.replaceCurrentItem(with: playerItems[currentTrack])
			player!.play()
		}
	}
	
	private func previousTrack() {
		if currentTrack - 1 < 0 {
			currentTrack =  (currentTrack - 1 + playerItems.count) % playerItems.count
		} else {
			currentTrack -= 1
		}
		
		playTrack()
	}
	
	private func nextTrack() {
		if currentTrack + 1 > playerItems.count {
			currentTrack = 0
		} else {
			currentTrack = (currentTrack + 1) % playerItems.count
		}
		
		playTrack()
	}
	
	// MARK: - Actions
	
	@objc func playNextTrack() {
		nextTrack()
	}
	
	@objc func playPreviousTrack() {
		previousTrack()
	}
	
	@objc func pausePressed() {
		if isPlaying {
			player?.pause()
			pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
		} else {
			player?.play()
			pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
		}
		
		isPlaying = !isPlaying
	}
	
	@objc func cancelPressed() {
		self.removeFromSuperview()
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
	
}

class VideoLauncher: NSObject {
	
	var view: UIView
	var playerView: VideoPlayerView
	
	init(view: UIView, playerView: VideoPlayerView) {
		self.view = view
		self.playerView = playerView
	}
	
	func showVideoPlayer() {
		view.backgroundColor = UIColor.white
		view.addSubview(playerView)
	}
	
	func removePlayer() {
		playerView.removeFromSuperview()
	}
	
}
