//
//  AddTodoView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct AddTodoView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority: TodoItem.Priority = .medium
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Title", text: $title)
                    
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker("Select Date", selection: $dueDate, displayedComponents: .date)
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority Level", selection: $priority) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(priorityColor(priority))
                                    .frame(width: 12, height: 12)
                                Text(priority.rawValue)
                            }
                            .tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Image(systemName: priorityIconName(priority))
                                .font(.system(size: 40))
                                .foregroundColor(priorityColor(priority))
                            Text("\(priority.rawValue) Priority")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTodoItem()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    func saveTodoItem() {
        let item = TodoItem(
            title: title,
            description: description,
            dueDate: dueDate,
            priority: priority,
            isCompleted: false
        )
        
        viewModel.addTodoItem(item)
        dismiss()
    }
    
    func priorityColor(_ priority: TodoItem.Priority) -> Color {
        switch priority {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
    
    func priorityIconName(_ priority: TodoItem.Priority) -> String {
        switch priority {
        case .low: return "arrow.down.circle.fill"
        case .medium: return "arrow.right.circle.fill"
        case .high: return "arrow.up.circle.fill"
        }
    }
}

#Preview {
    AddTodoView()
        .environmentObject(AppViewModel())
}
