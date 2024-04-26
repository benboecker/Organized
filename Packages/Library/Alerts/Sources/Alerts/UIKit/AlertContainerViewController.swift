//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.08.23.
//

import Foundation
import UIKit


class AlertContainerViewController: UIViewController {
	
	let childViewController: UIViewController
	
	private let expandHorizontally: Bool
	private let expandVertically: Bool
	
	init(withChildViewController childViewController: UIViewController, expandHorizontally: Bool, expandVertically: Bool) {
		self.childViewController = childViewController
		self.expandHorizontally = expandHorizontally
		self.expandVertically = expandVertically
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UIViewController overrides
extension AlertContainerViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.75)
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(backgroundView)
		
		addChild(childViewController)
		view.addSubview(childViewController.view)
		childViewController.didMove(toParent: self)
		
		childViewController.view.backgroundColor = .white
		childViewController.view.layer.cornerRadius = 6
		childViewController.view.layer.cornerCurve = .continuous
		
		childViewController.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			childViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			childViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		
		if expandHorizontally {
			childViewController.view.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
		} else {
			childViewController.view.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
		}
		
		if expandVertically {
			childViewController.view.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9).isActive = true
		} else {
			childViewController.view.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9).isActive = true
		}
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		backgroundView.addGestureRecognizer(tapGesture)
	}
	
	@objc func handleTap(_ gesture: UITapGestureRecognizer) {
		AlertPresenter.shared.dismissAlert()
	}
}
