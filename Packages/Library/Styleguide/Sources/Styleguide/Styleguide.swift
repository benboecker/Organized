import SwiftUI



public struct Styleguide {
	public init(fonts: Styleguide.Fonts, colors: Colors) {
		self.fonts = fonts
		self.colors = colors
	}
	
	let fonts: Fonts
	let colors: Colors
}


extension Styleguide {
	static let `default` = Styleguide(
		fonts: Fonts(
			body: .system(.body, design: .serif, weight: .medium),
			headline: .system(.headline, design: .serif, weight: .heavy),
			title: .system(.title2, design: .serif, weight: .heavy),
			largeTitle: .system(.largeTitle, design: .serif, weight: .heavy),
			caption: .system(.caption, design: .serif, weight: .bold)
		),
		colors: Colors(
			primaryText: .init(light: "#111111", dark: "#EEEEEE"),
			secondaryText: .init(light: "#999999", dark: "#CCCCCC"),
			accent: .init(light: "##e84118", dark: "##e84118"),
			primaryBackground: .init(light: "#FEFEFE", dark: "#111111"),
			secondaryBackground: .init(light: "#EEEEEE", dark: "#222222")
		)
	)
}


private struct StyleguideKey: EnvironmentKey {
	static let defaultValue = Styleguide.default
}

public extension EnvironmentValues {
	var styleguide: Styleguide {
		get { self[StyleguideKey.self] }
		set { self[StyleguideKey.self] = newValue }
	}
}



#Preview {
	ShowcaseView()
}
