//
//  AppViewModel.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import Foundation
import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var todoItems: [TodoItem] = []
    @Published var transactions: [Transaction] = []
    
    init() {
        loadSampleData()
    }
    
    // MARK: - Event Methods
    func addEvent(_ event: Event) {
        events.append(event)
    }
    
    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
    
    // MARK: - Todo Methods
    func addTodoItem(_ item: TodoItem) {
        todoItems.append(item)
    }
    
    func toggleTodoCompletion(_ item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
    
    func deleteTodoItem(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    
    // MARK: - Transaction Methods
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    var totalBalance: Double {
        transactions.reduce(0) { result, transaction in
            result + (transaction.type == .income ? transaction.amount : -transaction.amount)
        }
    }
    
    var totalIncome: Double {
        transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenses: Double {
        transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - Sample Data
    private func loadSampleData() {
        // Sample Events
        events = [
            Event(title: "Team Meeting", date: Date(), time: "10:00 AM", category: "Work", notes: "Discuss project progress"),
            Event(title: "Dentist Appointment", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, time: "2:00 PM", category: "Health", notes: "Regular checkup")
        ]
        
        // Sample Todo Items
        todoItems = [
            TodoItem(title: "Complete Assignment", description: "Finish iOS midterm project", dueDate: Date(), priority: .high, isCompleted: false),
            TodoItem(title: "Grocery Shopping", description: "Buy vegetables and fruits", dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, priority: .medium, isCompleted: false),
            TodoItem(title: "Read Chapter 5", description: "Swift programming book", dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, priority: .low, isCompleted: true)
        ]
        
        // Sample Transactions
        transactions = [
            Transaction(title: "Salary", amount: 3000.00, category: "Work", type: .income, date: Date(), notes: "Monthly salary"),
            Transaction(title: "Groceries", amount: 150.50, category: "Food", type: .expense, date: Date(), notes: "Weekly shopping"),
            Transaction(title: "Gas", amount: 45.00, category: "Transport", type: .expense, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, notes: "Fill up")
        ]
    }
}
