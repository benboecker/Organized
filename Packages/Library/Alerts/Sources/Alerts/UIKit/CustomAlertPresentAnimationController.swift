//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 30.08.23.
//

import Foundation
import UIKit


class CustomAlertPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		0.2
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard
			let toViewController = transitionContext.viewController(forKey: .to),
			let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true)
		else {
			return
		}
		
		let containerView = transitionContext.containerView
		let finalFrame = transitionContext.finalFrame(for: toViewController)
		
		snapshot.frame = finalFrame
		snapshot.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		snapshot.alpha = 0.0
		
		containerView.addSubview(toViewController.view)
		containerView.addSubview(snapshot)
		
		toViewController.view.isHidden = true
		
		let duration = transitionDuration(using: transitionContext)
		
		UIView.animate(withDuration: duration) {
			snapshot.alpha = 1.0
			snapshot.transform = CGAffineTransform(scaleX: 1, y: 1)
		} completion: { _ in
			toViewController.view.isHidden = false
			snapshot.removeFromSuperview()
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
	}
}

