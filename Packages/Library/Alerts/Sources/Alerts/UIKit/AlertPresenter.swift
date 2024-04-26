//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 29.08.23.
//

import Foundation
import OSLog
import UIKit



public class AlertPresenter {
	public static let shared = AlertPresenter()
	
	private var alertWindows = Set<AlertWindow>()
}


public extension AlertPresenter {
	func present(
		_ viewController: UIViewController,
		expandHorizontally: Bool = false,
		expandVertically: Bool = false
	) {
		guard let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			return
		}
		
		os_log(.info, "Alert being presented")

		let alertWindow = AlertWindow(
			with: viewController,
			in: currentWindowScene,
			expandHorizontally: expandHorizontally,
			expandVertically: expandVertically
		)
		
		alertWindow.present()
		alertWindows.insert(alertWindow)
	}
	
	func dismissAlert(_ completion: @escaping (() -> Void) = { }) {
		let keyWindow = alertWindows.first { window in
			window.isKeyWindow
		}
		
		guard let keyWindow else {
			return
		}
		
		os_log(.info, "Alert being dismissed")

		keyWindow.dismiss { [weak self] in
			self?.alertWindows.remove(keyWindow)
			completion()
		}
	}
}
