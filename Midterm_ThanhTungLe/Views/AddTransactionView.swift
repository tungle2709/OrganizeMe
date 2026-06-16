//
//  AddTransactionView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var amount = ""
    @State private var category = "Food"
    @State private var type: Transaction.TransactionType = .expense
    @State private var date = Date()
    @State private var notes = ""
    
    let categories = ["Food", "Transport", "Shopping", "Entertainment", "Health", "Work", "Education", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Type")) {
                    Picker("Type", selection: $type) {
                        ForEach(Transaction.TransactionType.allCases, id: \.self) { type in
                            HStack {
                                Image(systemName: type == .income ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                                    .foregroundColor(type == .income ? .green : .red)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Transaction Details")) {
                    TextField("Title", text: $title)
                    
                    HStack {
                        Text("$")
                            .foregroundColor(.gray)
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Additional Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 80)
                }
                
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Image(systemName: type == .income ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(type == .income ? .green : .red)
                            
                            if let amountValue = Double(amount), !amount.isEmpty {
                                Text("\(type == .income ? "+" : "-")$\(String(format: "%.2f", amountValue))")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(type == .income ? .green : .red)
                            } else {
                                Text("Enter amount")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTransaction()
                    }
                    .disabled(!isValidForm)
                }
            }
        }
    }
    
    var isValidForm: Bool {
        !title.isEmpty && !amount.isEmpty && Double(amount) != nil
    }
    
    func saveTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let transaction = Transaction(
            title: title,
            amount: amountValue,
            category: category,
            type: type,
            date: date,
            notes: notes
        )
        
        viewModel.addTransaction(transaction)
        dismiss()
    }
}

#Preview {
    AddTransactionView()
        .environmentObject(AppViewModel())
}
