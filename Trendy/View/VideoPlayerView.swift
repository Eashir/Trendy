//
//  VideoPlayerView.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/10/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import AVKit
import AVFoundation

class VideoPlayerView: UIView {

	var player: AVPlayer? {
		get {
			return playerLayer.player
		}
		set {
			playerLayer.player = newValue
		}
	}

	override class var layerClass: AnyClass {
		return AVPlayerLayer.self
	}
	
	var playerLayer: AVPlayerLayer {
		return layer as! AVPlayerLayer
	}
}
