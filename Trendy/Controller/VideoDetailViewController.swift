//
//  VideoDetailViewController.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/9/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit
import AVKit

class VideoDetailViewController: AVPlayerViewController {
	
	var video: Video?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(false)
		
	}
	
}
