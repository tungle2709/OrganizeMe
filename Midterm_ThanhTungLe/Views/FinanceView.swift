//
//  FinanceView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct FinanceView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Summary Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        FinanceSummaryCard(
                            title: "Total Balance",
                            amount: viewModel.totalBalance,
                            icon: "dollarsign.circle.fill",
                            color: .blue
                        )
                        
                        FinanceSummaryCard(
                            title: "Income",
                            amount: viewModel.totalIncome,
                            icon: "arrow.down.circle.fill",
                            color: .green
                        )
                        
                        FinanceSummaryCard(
                            title: "Expenses",
                            amount: viewModel.totalExpenses,
                            icon: "arrow.up.circle.fill",
                            color: .red
                        )
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
                
                // Transactions List
                List {
                    if viewModel.transactions.isEmpty {
                        HStack {
                            Spacer()
                            VStack(spacing: 10) {
                                Image(systemName: "dollarsign.circle")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                Text("No transactions yet")
                                    .foregroundColor(.gray)
                                Text("Tap + to add a transaction")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            Spacer()
                        }
                    } else {
                        Section(header: Text("Recent Transactions")) {
                            ForEach(sortedTransactions) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                            .onDelete(perform: deleteTransactions)
                        }
                    }
                }
            }
            .navigationTitle("Finance")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTransaction = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView()
            }
        }
    }
    
    var sortedTransactions: [Transaction] {
        viewModel.transactions.sorted { $0.date > $1.date }
    }
    
    func deleteTransactions(at offsets: IndexSet) {
        let transactionsToDelete = offsets.map { sortedTransactions[$0] }
        for transaction in transactionsToDelete {
            if let index = viewModel.transactions.firstIndex(where: { $0.id == transaction.id }) {
                viewModel.transactions.remove(at: index)
            }
        }
    }
}

struct FinanceSummaryCard: View {
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Spacer()
            }
            
            Text("$\(String(format: "%.2f", amount))")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 160)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(transaction.type == .income ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: transaction.type == .income ? "arrow.down" : "arrow.up")
                        .foregroundColor(transaction.type == .income ? .green : .red)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(transaction.title)
                    .font(.headline)
                
                HStack {
                    Text(transaction.category)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                    
                    Text(transaction.dateString)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text(transaction.amountString)
                .font(.headline)
                .foregroundColor(transaction.type == .income ? .green : .red)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    FinanceView()
        .environmentObject(AppViewModel())
}
