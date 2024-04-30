//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 28.04.24.
//

import Foundation
import SwiftUI



protocol Repository {
	func getStuff()
}

struct RepositoryKey: EnvironmentKey {
	static let defaultValue: any Repository = TheRepository()
}

extension EnvironmentValues {
	var repository: Repository {
		get { self[RepositoryKey.self] }
		set { self[RepositoryKey.self] = newValue }
	}
}


class TheRepository: Repository {
	func getStuff() {
		print("yeah")
	}
}

class AnotherRepository: Repository {
	func getStuff() {
		print("FUCK YEAH")
	}
}


struct TestView: View {
	@Environment(\.repository) var repo
	var body: some View {
		Button("Push me") {
			repo.getStuff()
		}
	}
}

#Preview {
	TestView()
		.environment(\.repository, AnotherRepository())
}
