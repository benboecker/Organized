//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 30.08.23.
//

import Foundation
import UIKit


class CustomAlertDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		0.2
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard
			let fromViewController = transitionContext.viewController(forKey: .from),
			let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)
		else {
			return
		}
		
		let containerView = transitionContext.containerView
		let finalFrame = transitionContext.finalFrame(for: fromViewController)

		snapshot.frame = finalFrame

		containerView.addSubview(snapshot)
		fromViewController.view.isHidden = true

		let duration = transitionDuration(using: transitionContext)

		UIView.animate(withDuration: duration) {
			snapshot.alpha = 0.0
		} completion: { _ in
			snapshot.removeFromSuperview()
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
	}
}
