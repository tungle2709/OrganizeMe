//
//  HomeView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Header
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome Back!")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(Date().formatted(date: .long, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Image(systemName: "bell.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
                    // Quick Stats
                    VStack(spacing: 15) {
                        HStack(spacing: 15) {
                            StatCard(
                                title: "Events",
                                value: "\(viewModel.events.count)",
                                icon: "calendar",
                                color: .blue
                            )
                            
                            StatCard(
                                title: "Tasks",
                                value: "\(viewModel.todoItems.filter { !$0.isCompleted }.count)",
                                icon: "checklist",
                                color: .orange
                            )
                        }
                        
                        HStack(spacing: 15) {
                            StatCard(
                                title: "Balance",
                                value: "$\(String(format: "%.0f", viewModel.totalBalance))",
                                icon: "dollarsign.circle",
                                color: .green
                            )
                            
                            StatCard(
                                title: "Completed",
                                value: "\(viewModel.todoItems.filter { $0.isCompleted }.count)",
                                icon: "checkmark.circle",
                                color: .purple
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Upcoming Events
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Upcoming Events")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: CalendarView()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        if viewModel.events.isEmpty {
                            Text("No upcoming events")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(viewModel.events.prefix(3)) { event in
                                EventRowCard(event: event)
                            }
                        }
                    }
                    
                    // Recent Tasks
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Today's Tasks")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: TodoListView()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        if viewModel.todoItems.filter({ !$0.isCompleted }).isEmpty {
                            Text("No pending tasks")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(viewModel.todoItems.filter { !$0.isCompleted }.prefix(3)) { item in
                                TodoRowCard(item: item)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct EventRowCard: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 15) {
            VStack {
                Text(Calendar.current.component(.day, from: event.date).description)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(event.date.formatted(.dateTime.month(.abbreviated)))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(width: 50)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text(event.time)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text(event.category)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct TodoRowCard: View {
    let item: TodoItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundColor(item.isCompleted ? .green : .gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isCompleted)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(item.priority.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(priorityColor(item.priority).opacity(0.2))
                .foregroundColor(priorityColor(item.priority))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    func priorityColor(_ priority: TodoItem.Priority) -> Color {
        switch priority {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppViewModel())
}
