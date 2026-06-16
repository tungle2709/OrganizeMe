//
//  TodoItem.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import Foundation

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var priority: Priority
    var isCompleted: Bool
    
    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }
    
    var dueDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: dueDate)
    }
}
