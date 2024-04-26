//
//  Delegates.swift
//  AlertTest
//
//  Created by Benjamin Böcker on 02.04.24.
//

import Foundation
import SwiftUI
import UIKit
import Observation


@available(iOS 17.0, *)
class AlertManager {
	static let shared = AlertManager()
	var overlayWindow: UIWindow?	
	var alerts: [UIView] = []
	
	private init() {
		guard let theScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			return
		}
		
		let window = UIWindow(windowScene: theScene)
		window.isUserInteractionEnabled = true
		window.windowLevel = .alert
		overlayWindow = window
	}
	
	func presentAlert<Content: View>(
		alertPresented: Binding<Bool>,
		displayConfig: DisplayConfig,
		@ViewBuilder content: @escaping () -> Content
	) {
		guard let alertWindow = overlayWindow else { return }
		
		let alertView = AlertView(
			displayConfig: displayConfig,
			alertPresented: alertPresented,
			content: content
		)
		let viewController = UIHostingController(rootView: alertView)
		viewController.view.backgroundColor = .clear
		
		if let presentedAlertController = alertWindow.rootViewController {
			viewController.view.frame = presentedAlertController.view.frame
			alerts.append(viewController.view)
		} else {
			alertWindow.rootViewController = viewController
			alertWindow.isHidden = false
			alertWindow.isUserInteractionEnabled = true
			alertWindow.makeKeyAndVisible()
		}
	}
	
	func dismissAlert(displayConfig: DisplayConfig) {
		guard let alertWindow = overlayWindow else { return }
		
		DispatchQueue.main.asyncAfter(deadline: .now() + displayConfig.durationOut) { [unowned self] in
			if alerts.isEmpty {
				alertWindow.rootViewController = nil
				alertWindow.isHidden = true
				alertWindow.resignKey()
				alertWindow.isUserInteractionEnabled = false
			} else {
				if let first = alerts.first {
					alertWindow.rootViewController?.view.subviews.forEach { view in
						view.removeFromSuperview()
					}
					
					alertWindow.rootViewController?.view.addSubview(first)
					alerts.removeFirst()
				}
			}
		}

	}
}


#Preview {
	AlertPreview()
}
