//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 25.04.24.
//

import SwiftUI



struct DateSelection: View {
	
	@Binding var selectedDate: Date
	
    var body: some View {
		DatePicker("", selection: $selectedDate, displayedComponents: .date)
			.datePickerStyle(.graphical)
    }
}



#Preview {
	DateSelection(selectedDate: .constant(.now))
}
