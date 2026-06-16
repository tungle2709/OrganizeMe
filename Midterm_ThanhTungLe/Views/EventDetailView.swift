//
//  EventDetailView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.blue)
                        Text(event.category)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                // Date & Time
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Date")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(event.dateString)
                                .font(.headline)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "clock")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Time")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(event.time)
                                .font(.headline)
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                // Notes
                if !event.notes.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "note.text")
                                .foregroundColor(.blue)
                            Text("Notes")
                                .font(.headline)
                        }
                        
                        Text(event.notes)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                
                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        EventDetailView(event: Event(
            title: "Team Meeting",
            date: Date(),
            time: "10:00 AM",
            category: "Work",
            notes: "Discuss project progress and upcoming deadlines"
        ))
    }
}
