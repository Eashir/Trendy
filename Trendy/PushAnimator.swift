//
//  FadePushAnimator.swift
//  Trendy
//
//  Created by Eashir Arafat on 11/8/19.
//  Copyright © 2019 eashirarafat. All rights reserved.
//

import UIKit

open class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.5
	}
	
	open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let toViewController = transitionContext.viewController(forKey: .to) else {
			return
		}
		
		transitionContext.containerView.addSubview(toViewController.view)
		toViewController.view.alpha = 0
		
		let duration = self.transitionDuration(using: transitionContext)
		UIView.animate(withDuration: duration, animations: {
			toViewController.view.alpha = 1
		}, completion: { _ in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		})
	}
	
}
