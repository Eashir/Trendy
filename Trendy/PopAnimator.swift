//
//  FadePopAnimator.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

open class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.5
	}
	
	open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let fromViewController = transitionContext.viewController(forKey: .from),
			let toViewController = transitionContext.viewController(forKey: .to) else {
				return
		}
		
		transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
		
		let duration = self.transitionDuration(using: transitionContext)
		UIView.animate(withDuration: duration, animations: {
			fromViewController.view.alpha = 0
		}, completion: { _ in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		})
	}
	
}
