//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.08.23.
//

import Foundation
import UIKit



class AlertWindow: UIWindow {
	private let holdingViewController: HoldingViewController
	
	init(with viewController: UIViewController, in windowScene: UIWindowScene, expandHorizontally: Bool, expandVertically: Bool) {
		holdingViewController = HoldingViewController(
			with: viewController,
			expandHorizontally: expandHorizontally,
			expandVertically: expandVertically
		)
		
		super.init(windowScene: windowScene)
		
		rootViewController = holdingViewController
		windowLevel = .alert
	}
	
	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
}

extension AlertWindow {
	var viewController: UIViewController {
		holdingViewController.containerViewController.childViewController
	}
	
	func present() {
		makeKeyAndVisible()
	}

	func dismiss(completion: @escaping (() -> Void)) {
		holdingViewController.dismissAlert { [weak self] in
			self?.resignKeyAndHide()
			completion()
		}
	}
	
	private func resignKeyAndHide() {
		resignKey()
		isHidden = true
	}
}
