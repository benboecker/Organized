//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 04.07.24.
//

import SwiftUI
import Styleguide


public struct WeekdayView: View {
	public init(date: Date) {
		self.date = date
	}
	
	private let date: Date
	
	@Environment(\.styleguide) private var styleguide
	
    public var body: some View {
		HStack(spacing: styleguide.medium) {
			Text(date, format: .dateTime.weekday(.wide))
				.font(styleguide.title)
				.foregroundStyle(styleguide.primaryText)
			
			Text(date, format: .dateTime.day().month(.wide))
				.font(styleguide.title)
				.foregroundStyle(styleguide.secondaryText)
		}
	}
}

#Preview {
	VStack(alignment: .leading, spacing: 24) {
		WeekdayView(date: .now)
		WeekdayView(date: .now.addingTimeInterval(86400 * 1))
		WeekdayView(date: .now.addingTimeInterval(86400 * 2))
		WeekdayView(date: .now.addingTimeInterval(86400 * 3))
		WeekdayView(date: .now.addingTimeInterval(86400 * 4))
		WeekdayView(date: .now.addingTimeInterval(86400 * 5))
		WeekdayView(date: .now.addingTimeInterval(86400 * 6))
	}
	.styledPreview()
}
