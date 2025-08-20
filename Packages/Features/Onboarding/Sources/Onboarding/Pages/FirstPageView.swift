//
//  FirstPageView.swift
//  Onboarding
//
//  Created by Benjamin Böcker on 14.07.24.
//

import SwiftUI
import Styleguide
import SharedComponents
import SwiftUITools



struct FirstPageView: View {
	@Environment(\.styleguide) private var styleguide
	
	var body: some View {
		VStack(spacing: styleguide.extraLarge) {
			Spacer()
			TitleView()
			Spacer()
			AnimationView()
			Spacer()
			DescriptionView()
			Spacer()
		}
		.padding(.horizontal, styleguide.extraLarge)
	}
	
	func TitleView() -> some View {
		VStack(spacing: styleguide.small) {
			Text("Welcome to")
				.foregroundStyle(styleguide.foregroundSecondary)
				.foregroundStyle(Color.red)
			Text("Organized")
				.foregroundStyle(styleguide.foregroundPrimary)
		}
		.font(styleguide.headline1)
	}
	
	func DescriptionView() -> some View {
		Text("This is the first onboarding text. Something interesting should be written here.")
			.font(styleguide.body1)
			.foregroundStyle(styleguide.foregroundPrimary)
			.multilineTextAlignment(.center)
	}
}

private struct AnimationView: View {
	@Environment(\.styleguide) private var styleguide

	
	var body: some View {
		VStack(alignment: .leading, spacing: styleguide.medium) {
			WeekdayView(date: .now)
				.padding(.leading, styleguide.extraLarge + styleguide.medium)
			FakeTodoView(title: "Input some todos", isImportant: true, isDone: false)
			FakeTodoView(title: "Get things done", isImportant: false, isDone: false)
			FakeTodoView(title: "Spend more time being happy", isImportant: false, isDone: true)
		}
	}
	
	
	func FakeTodoView(title: String, isImportant: Bool, isDone: Bool) -> some View {
		HStack(spacing: styleguide.large) {
			StatusView(isDone: .constant(isDone), status: isImportant ? .important : .normal)
				.disabled(true)
			Text(title)
				.font(styleguide.body1)
				.foregroundStyle(isDone ? styleguide.foregroundSecondary : styleguide.foregroundPrimary)
		}
	}
}



#Preview {
	FirstPageView()
		.padding(.horizontal)
		.styledPreview()
}
