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
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)
		homeViewModel = HomeViewModel(tableView: tableView, navigationController: self.navigationController!)
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

