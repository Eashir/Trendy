//
//  HomeViewController.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
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

