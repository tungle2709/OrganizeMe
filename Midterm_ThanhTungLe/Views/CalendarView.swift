//
//  CalendarView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingAddEvent = false
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Calendar Section
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(Color(.systemBackground))
                
                Divider()
                
                // Events List
                List {
                    Section {
                        if filteredEvents.isEmpty {
                            HStack {
                                Spacer()
                                VStack(spacing: 10) {
                                    Image(systemName: "calendar.badge.exclamationmark")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                    Text("No events scheduled")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                Spacer()
                            }
                        } else {
                            ForEach(filteredEvents) { event in
                                NavigationLink(destination: EventDetailView(event: event)) {
                                    EventRow(event: event)
                                }
                            }
                            .onDelete(perform: deleteEvents)
                        }
                    } header: {
                        Text("Events for \(selectedDate.formatted(date: .long, time: .omitted))")
                    }
                }
            }
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddEvent = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddEvent) {
                AddEventView()
            }
        }
    }
    
    var filteredEvents: [Event] {
        viewModel.events.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    func deleteEvents(at offsets: IndexSet) {
        let eventsToDelete = offsets.map { filteredEvents[$0] }
        for event in eventsToDelete {
            if let index = viewModel.events.firstIndex(where: { $0.id == event.id }) {
                viewModel.events.remove(at: index)
            }
        }
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Label(event.time, systemImage: "clock")
                        .font(.subheadline)
                    
                    Label(event.category, systemImage: "tag")
                        .font(.subheadline)
                }
                .foregroundColor(.gray)
                
                if !event.notes.isEmpty {
                    Text(event.notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CalendarView()
        .environmentObject(AppViewModel())
}
