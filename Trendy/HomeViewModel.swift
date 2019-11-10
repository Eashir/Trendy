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
	private var tableView: UITableView
	private var navigationController: UINavigationController
	
	init(tableView: UITableView, navigationController: UINavigationController) {
		self.tableView = tableView
		self.navigationController = navigationController
		super.init()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		getAllTrendingVideos()
	}
	
	func getAllTrendingVideos() {
		Video.getAllTrendingVideos { videos in
			guard let validVideos = videos else {
				return
			}
			self.videos = validVideos
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
}

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
		let video = videos[indexPath.row]
		cell.setupCell(video: video)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let video = videos[indexPath.row]
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let videoDetailVC = storyboard.instantiateViewController(withIdentifier: "videoDetailVC") as! VideoDetailViewController
		videoDetailVC.video = video
		self.navigationController.pushViewController(videoDetailVC, animated: true)
	}
	
}
