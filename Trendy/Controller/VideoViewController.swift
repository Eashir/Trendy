//
//  VideoViewController.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/10/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import AVFoundation

class VideoViewController: UIViewController {
	var videoLauncher: VideoLauncher?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		videoLauncher?.removePlayer()
		videoLauncher?.playerView.player?.removeObserver(videoLauncher!.playerView, forKeyPath: "currentItem.loadedTimeRanges")
		videoLauncher?.playerView.player = nil
		
	}
	
}
