//
//  TodoListView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingAddTodo = false
    @State private var showCompleted = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Toggle
                HStack {
                    Text("Show Completed")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Toggle("", isOn: $showCompleted)
                }
                .padding()
                .background(Color(.systemBackground))
                
                // Todo List
                List {
                    if !pendingItems.isEmpty {
                        Section(header: Text("Pending Tasks")) {
                            ForEach(pendingItems) { item in
                                TodoItemRow(item: item)
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.toggleTodoCompletion(item)
                                        }
                                    }
                            }
                            .onDelete { offsets in
                                deleteTodos(from: pendingItems, at: offsets)
                            }
                        }
                    }
                    
                    if showCompleted && !completedItems.isEmpty {
                        Section(header: Text("Completed Tasks")) {
                            ForEach(completedItems) { item in
                                TodoItemRow(item: item)
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.toggleTodoCompletion(item)
                                        }
                                    }
                            }
                            .onDelete { offsets in
                                deleteTodos(from: completedItems, at: offsets)
                            }
                        }
                    }
                    
                    if pendingItems.isEmpty && completedItems.isEmpty {
                        HStack {
                            Spacer()
                            VStack(spacing: 10) {
                                Image(systemName: "checklist")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                Text("No tasks yet")
                                    .foregroundColor(.gray)
                                Text("Tap + to add a new task")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTodo = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView()
            }
        }
    }
    
    var pendingItems: [TodoItem] {
        viewModel.todoItems.filter { !$0.isCompleted }.sorted { $0.dueDate < $1.dueDate }
    }
    
    var completedItems: [TodoItem] {
        viewModel.todoItems.filter { $0.isCompleted }.sorted { $0.dueDate < $1.dueDate }
    }
    
    func deleteTodos(from items: [TodoItem], at offsets: IndexSet) {
        let itemsToDelete = offsets.map { items[$0] }
        for item in itemsToDelete {
            if let index = viewModel.todoItems.firstIndex(where: { $0.id == item.id }) {
                viewModel.todoItems.remove(at: index)
            }
        }
    }
}

struct TodoItemRow: View {
    let item: TodoItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(item.isCompleted ? .green : .gray)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Label(item.dueDateString, systemImage: "calendar")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(item.priority.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(priorityColor(item.priority).opacity(0.2))
                        .foregroundColor(priorityColor(item.priority))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 8)
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
    TodoListView()
        .environmentObject(AppViewModel())
}
