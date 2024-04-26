//
//  SwiftUIView.swift
//
//
//  Created by Benjamin Böcker on 01.03.24.
//

import SwiftUI


struct GetProposedSizeLayout: Layout {
	var didSetProposal: (CGSize) -> Void
	
	func sizeThatFits(
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) -> CGSize {
		let result = subviews[0].sizeThatFits(proposal)
		didSetProposal(CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0))
		return result
	}
	
	func placeSubviews(
		in bounds: CGRect,
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) {
		subviews[0].place(at: bounds.origin, proposal: proposal)
	}
}


struct DebugView<Content: View>: View {
	private let content: Content
	private let color: Color
	private let alignment: Alignment
	private let showSize: Bool
	@State private var proposedSize: CGSize = .zero
	
	public init (
		_ color: Color,
		alignment: Alignment,
		showSize: Bool,
		@ViewBuilder _ content: () -> Content
	) {
		self.content = content()
		self.alignment = alignment
		self.color = color
		self.showSize = showSize
	}
	
	var body: some View {
		GetProposedSizeLayout(didSetProposal: {
			proposedSize = $0
		}) {
			content
				.overlay {
					GeometryReader { proxy in
						RoundedRectangle(cornerRadius: 4)
							.stroke(color, lineWidth: 1)
						if showSize {
							VStack {
								//							Text("\(Int(proposedSize.width)) x \(Int(proposedSize.height))")
								//								.font(.system(size: 8, weight: .black, design: .monospaced))
								Text("\(Int(proxy.size.width)) x \(Int(proxy.size.height))")
									.font(.system(.caption, design: .monospaced, weight: .heavy))
							}
							.foregroundStyle(.white)
							.padding(.horizontal, 8)
							.padding(.vertical, 4)
							.background(color.gradient, in: .rect(cornerRadius: 4))
							.fixedSize()
							.frame(width: proxy.size.width, height: proxy.size.height)
							.offset(offset(for: alignment, in: proxy.size))
						}
					}
				}
		}
	}
	
	func offset(for alignment: Alignment, in size: CGSize) -> CGSize {
		switch alignment {
		case .bottom:         CGSize(width: 0,               height: size.height / 2)
		case .bottomLeading:  CGSize(width: -size.width / 2, height: size.height / 2)
		case .bottomTrailing: CGSize(width: size.width / 2,  height: size.height / 2)
		case .top:            CGSize(width: 0,               height: -size.height / 2)
		case .topLeading:     CGSize(width: -size.width / 2, height: -size.height / 2)
		case .topTrailing:    CGSize(width: size.width / 2,  height: -size.height / 2)
		case .leading:        CGSize(width: -size.width / 2, height: 0)
		case .trailing:       CGSize(width: size.width / 2,  height: 0)
		default: .zero
		}
	}
}

public extension View {
	func debugFrame(_ color: Color = .blue, alignment: Alignment = .bottom, showSize: Bool = true) -> some View {
#if DEBUG
		DebugView(color, alignment: alignment, showSize: showSize) {
			self
		}
#else
		self
#endif
	}
}


#Preview {
	ScrollView {
		VStack(spacing: 48) {
			Text("Top Leading")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .topLeading)
			Text("Top")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .top)
			Text("Top Trailing")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .topTrailing)
			Text("Leading")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .leading)
			Text("Center")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .center)
			Text("Trailing")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .trailing)
			Text("Bottom Leading")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .bottomLeading)
			Text("Bottom")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .bottom)
			Text("Bottom Trailing")
				.padding()
				.background(.green.opacity(0.15))
				.debugFrame(.blue, alignment: .bottomTrailing)
		}
		.padding(.top)
	}
	.scrollClipDisabled()
	.scrollIndicators(.hidden)
}
