//
//  HomeViewModel.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
	
	var videos = [Video]()
	let VideoCellReuseIdentifier = "VideoCell"
	let fullscreenPlayerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
	private var tableView: UITableView
	private var navigationController: UINavigationController
	
	init(tableView: UITableView, navigationController: UINavigationController) {
		self.tableView = tableView
		self.navigationController = navigationController
		super.init()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		getVideos()
	}
	
	func getVideos() {
		Video.getAllTrendingVideos { [weak self] videos in
			guard let validVideos = videos else {return}
			guard let validSelf = self else {return}
			
			validSelf.videos = validVideos
			DispatchQueue.main.async {
				validSelf.tableView.reloadData()
			}
		}
	}
	
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension HomeViewModel: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return videos.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellReuseIdentifier, for: indexPath) as? VideoTableViewCell else {
			return VideoTableViewCell()
		}
		var video = videos[indexPath.row]
		if indexPath.row == 1 {
			video.url = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
		}
		cell.setupCell(video: video)
		cell.tableSuperView = self.tableView.superview
		cell.videos = videos
		return cell
	}
	
}
