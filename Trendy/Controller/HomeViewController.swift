//
//  HomeViewController.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	private var homeViewModel: HomeViewModel?
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
		homeViewModel = HomeViewModel(tableView: tableView, navigationController: self.navigationController!)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
}

// MARK: - UINavigationControllerDelegate

extension HomeViewController: UINavigationControllerDelegate {
	
	func navigationController(_ navigationController: UINavigationController,
														animationControllerFor operation: UINavigationController.Operation,
														from fromVC: UIViewController,
														to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		switch operation {
		case .push:
			return PushAnimator()
		case .pop:
			return PopAnimator()
		default:
			return nil
		}
	}

}

