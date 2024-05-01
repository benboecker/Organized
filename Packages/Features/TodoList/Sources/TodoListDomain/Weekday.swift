//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 23.04.24.
//

import Foundation


public struct Weekday: Decodable, Hashable {
	package init(date: Date, todos: [Todo]) {
		self.date = date
		self.todos = todos
	}
	
	package let date: Date
	package let todos: [Todo]

}

