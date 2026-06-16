//
//  Event.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import Foundation

struct Event: Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var time: String
    var category: String
    var notes: String
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
