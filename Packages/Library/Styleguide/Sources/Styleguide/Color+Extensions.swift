//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 22.04.24.
//

import Foundation
import SwiftUI
import UIKit


extension Color {

	init(light: String, dark: String) {
		self.init(uiColor: UIColor(dynamicProvider: { traitCollection in
			if traitCollection.userInterfaceStyle == .dark {
				return UIColor(hex: dark) ?? .red
			} else {
				return UIColor(hex: light) ?? .red
			}
		}))
	}

	init(light: Color, dark: Color) {
		self.init(uiColor: UIColor(dynamicProvider: { traitCollection in
			if traitCollection.userInterfaceStyle == .dark {
				return UIColor(cgColor: dark.cgColor!)
			} else {
				return UIColor(cgColor: light.cgColor!)
			}
		}))
	}


}


extension UIColor {
	public convenience init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: UInt64 = 0

		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 0.0

		let length = hexSanitized.count

		if Scanner(string: hexSanitized).scanHexInt64(&rgb) {
			if length == 6 {
				r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
				g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
				b = CGFloat(rgb & 0x0000FF) / 255.0
				a = 1.0
			} else if length == 8 {
				r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
				g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
				b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
				a = CGFloat(rgb & 0x000000FF) / 255.0
			}
		}

		self.init(red: r, green: g, blue: b, alpha: a)
	}

}

