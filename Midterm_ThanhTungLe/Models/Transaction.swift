//
//  Transaction.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id = UUID()
    var title: String
    var amount: Double
    var category: String
    var type: TransactionType
    var date: Date
    var notes: String
    
    enum TransactionType: String, Codable, CaseIterable {
        case income = "Income"
        case expense = "Expense"
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var amountString: String {
        let sign = type == .income ? "+" : "-"
        return "\(sign)$\(String(format: "%.2f", amount))"
    }
}
