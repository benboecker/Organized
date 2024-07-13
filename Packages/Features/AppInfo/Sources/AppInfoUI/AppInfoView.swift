//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 09.07.24.
//

import AppInfoDomain
import Settings
import SharedComponents
import Styleguide
import SwiftUI


public struct AppInfoView: View {
	public init() { }
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.styleguide) private var styleguide
	@Environment(\.settings) private var settings
	
    public var body: some View {
		NavigationStack {
			ScrollView {
				VStack(spacing: 0) {
					HeaderSection()
					SettingsSection()
					ProVersionSection()
					SocialSection()
					AppInfoSection()
				}
				.padding(.horizontal, styleguide.large)
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button {
						dismiss()
					} label: {
						Image(systemName: "xmark.circle.fill")
							.symbolRenderingMode(.hierarchical)
							.foregroundStyle(Color.secondary)
							.font(.title2.bold())
					}
				}
			}
		}
    }
}

private extension AppInfoView {
	func HeaderSection() -> some View {
		Section {
			VStack(spacing: 0) {
				Color.clear.frame(height: 0)
				Image(uiImage: UIImage(named: "app_icon", in: .module, with: nil)!)
					.resizable()
					.frame(width: 100, height: 100, alignment: .center)
					.clipShape(.rect(cornerRadius: 20))
					.shadow(color: .black.opacity(0.1), radius: 10, y: 4)
					.padding(.vertical, styleguide.extraLarge)
				
				Text("Organized")
					.font(styleguide.largeTitle)
					.foregroundStyle(styleguide.primaryText)
			}
			.padding(.bottom, styleguide.large)
		}
	}
	
	@ViewBuilder
	func SettingsSection() -> some View {
		Section {
			VStack(spacing: styleguide.medium) {
				Menu {
					Button("3", systemImage: settings.numberOfTodos == 3 ? "checkmark" : "") { withAnimation(.snappy) { settings.numberOfTodos = 3 } }
					Button("4", systemImage: settings.numberOfTodos == 4 ? "checkmark" : "") { withAnimation(.snappy) { settings.numberOfTodos = 4 } }
					Button("5", systemImage: settings.numberOfTodos == 5 ? "checkmark" : "") { withAnimation(.snappy) { settings.numberOfTodos = 5 } }
					Button("6", systemImage: settings.numberOfTodos == 6 ? "checkmark" : "") { withAnimation(.snappy) { settings.numberOfTodos = 6 } }
					Button("7", systemImage: settings.numberOfTodos == 7 ? "checkmark" : "") { withAnimation(.snappy) { settings.numberOfTodos = 7 } }
				} label: {
					HStack(alignment: .firstTextBaseline) {
						Text("Number of tasks per day")
							.font(styleguide.body)
							.foregroundStyle(styleguide.primaryText)
						Spacer()
						Text("\(settings.numberOfTodos)")
							.font(styleguide.headline)
							.foregroundStyle(styleguide.primaryText)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.contentShape(.rect)
					.rowBackground()
				}
				
				Menu {
					ForEach(Settings.ExcludedWeekday.all, id: \.self) { weekday in
						Button {
							withAnimation(.snappy) {
								settings.toggleWeekdayExcluded(weekday)
							}
						} label: {
							Label(weekday.name, systemImage: settings.isWeekdayExcluded(weekday) ? "checkmark" : "")
						}
					}
				} label: {
					HStack(alignment: .firstTextBaseline) {
						Text("Excluded weekdays")
							.font(styleguide.body)
							.foregroundStyle(styleguide.primaryText)
						Spacer()
						Text(settings.excludedWeekdaysDescription)
							.font(styleguide.headline)
							.foregroundStyle(styleguide.primaryText)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.contentShape(.rect)
					.rowBackground()
				}
				.menuActionDismissBehavior(.disabled)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		} header: {
			Text("Settings")
				.font(styleguide.headline)
				.foregroundStyle(styleguide.secondaryText)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.bottom, styleguide.medium)
				.padding(.top, styleguide.extraLarge)
		}

	}
	
	func ProVersionSection() -> some View {
		Section {
			VStack(spacing: styleguide.medium) {
				Label("Pro Version unlocked", systemImage: "checkmark.circle")
					.rowBackground()
			}
			.font(styleguide.body)
			.foregroundStyle(styleguide.primaryText)
		} header: {
			Text("Pro Version")
				.font(styleguide.headline)
				.foregroundStyle(styleguide.secondaryText)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.bottom, styleguide.medium)
				.padding(.top, styleguide.extraLarge)
		}

	}
	
	func SocialSection() -> some View {
		Section {
			VStack(spacing: styleguide.medium) {
				Label("Mastodon", systemImage: "smiley")
					.rowBackground()
				Label("Instagram", systemImage: "rectangle.on.rectangle.angled.fill")
					.rowBackground()
				Label("E-Mail", systemImage: "envelope")
					.rowBackground()
			}
			.font(styleguide.body)
			.foregroundStyle(styleguide.primaryText)
		} header: {
			Text("Contact")
				.font(styleguide.headline)
				.foregroundStyle(styleguide.secondaryText)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.bottom, styleguide.medium)
				.padding(.top, styleguide.extraLarge)
		}

	}
	
	func AppInfoSection() -> some View {
		Section {
			HStack(alignment: .firstTextBaseline, spacing: styleguide.small) {
				Text("App Version")
				Text(AppInfo.appVersion)
					.font(styleguide.headline)
//					.padding(.trailing, styleguide.medium)
				Text("Build \(AppInfo.buildNumber)")
			}
			.font(styleguide.caption)
			.foregroundStyle(styleguide.secondaryText)
			.padding(.top, styleguide.extraLarge)
		}
	}
}




struct RowBackground: ViewModifier {
	@Environment(\.styleguide) private var styleguide
	
	func body(content: Content) -> some View {
		content
			.padding(.vertical, styleguide.medium)
			.padding(.horizontal, styleguide.large)
			.frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
			.background(styleguide.secondaryBackground, in: .rect(cornerRadius: styleguide.medium))
	}
}


extension View {
	func rowBackground() -> some View {
		modifier(RowBackground())
	}
}




#Preview {
	AppInfoView()
		.styledPreview()
}
