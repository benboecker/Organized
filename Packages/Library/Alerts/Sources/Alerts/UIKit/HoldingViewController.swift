//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.08.23.
//

import Foundation
import UIKit


class HoldingViewController: UIViewController {
	let containerViewController: AlertContainerViewController
	
	init(with viewController: UIViewController, expandHorizontally: Bool, expandVertically: Bool) {
		self.containerViewController = AlertContainerViewController(
			withChildViewController: viewController,
			expandHorizontally: expandHorizontally,
			expandVertically: expandVertically
		)
		
		super.init(nibName: nil, bundle: nil)
		
		containerViewController.modalPresentationStyle = .custom
		containerViewController.transitioningDelegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


// MARK: - UIViewController overrides
extension HoldingViewController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		present(containerViewController, animated: true)
	}
}


// MARK: - Internal functions and properties
internal extension HoldingViewController {
	func dismissAlert(completion: @escaping (() -> Void)) {
		DispatchQueue.main.async { [weak self] in
			self?.containerViewController.dismiss(animated: true) {
				completion()
			}
		}
	}
}


// MARK: - UIViewControllerTransitioningDelegate
extension HoldingViewController: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		CustomAlertPresentAnimationController()
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		CustomAlertDismissAnimationController()
	}
}
