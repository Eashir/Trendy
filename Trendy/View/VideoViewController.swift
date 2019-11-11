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
	
	let videoPlaylistView = VideoPlaylistView(videos: Video.allVideos())
	
	var videos = [Video]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.addSubview(videoPlaylistView)
		for video in videoPlaylistView.videos {
			print(video.url)
		}
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
//		videoPlaylistView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		videoPlaylistView.frame = CGRect(x: view.bounds.width - 150 - 16, y: view.bounds.height - 100 - 16, width: 150, height: 100)
		videoPlaylistView.backgroundColor = .black
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		videoPlaylistView.play()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		videoPlaylistView.pause()
	}
	
	
}
