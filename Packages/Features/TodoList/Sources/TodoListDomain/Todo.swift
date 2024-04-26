//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation



public struct Todo: Decodable, Identifiable, Hashable {
	public let id: UUID
	package let title: String
	package let isDone: Bool
	package let isImportant: Bool
}
