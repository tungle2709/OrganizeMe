//
//  AddEventView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct AddEventView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var category = "Work"
    @State private var notes = ""
    
    let categories = ["Work", "Personal", "Health", "Education", "Social", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Title", text: $title)
                    
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                }
                
                Section(header: Text("Additional Information")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEvent()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    func saveEvent() {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        let timeString = timeFormatter.string(from: selectedTime)
        
        let event = Event(
            title: title,
            date: selectedDate,
            time: timeString,
            category: category,
            notes: notes
        )
        
        viewModel.addEvent(event)
        dismiss()
    }
}

#Preview {
    AddEventView()
        .environmentObject(AppViewModel())
}
