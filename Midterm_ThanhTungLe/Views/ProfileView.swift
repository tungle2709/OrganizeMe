//
//  ProfileView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var username = "Thanh Tung Le"
    @State private var email = "tungle@example.com"
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    
    var body: some View {
        NavigationView {
            List {
                // Profile Header
                Section {
                    HStack(spacing: 15) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text(getInitials(from: username))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(username)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                // Statistics
                Section(header: Text("Statistics")) {
                    StatisticRow(icon: "calendar", title: "Total Events", value: "\(viewModel.events.count)", color: .blue)
                    StatisticRow(icon: "checklist", title: "Total Tasks", value: "\(viewModel.todoItems.count)", color: .orange)
                    StatisticRow(icon: "checkmark.circle.fill", title: "Completed Tasks", value: "\(viewModel.todoItems.filter { $0.isCompleted }.count)", color: .green)
                    StatisticRow(icon: "dollarsign.circle.fill", title: "Transactions", value: "\(viewModel.transactions.count)", color: .purple)
                }
                
                // Settings
                Section(header: Text("Settings")) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Notifications")
                        Spacer()
                        Toggle("", isOn: $notificationsEnabled)
                    }
                    
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.indigo)
                            .frame(width: 30)
                        Text("Dark Mode")
                        Spacer()
                        Toggle("", isOn: $darkModeEnabled)
                    }
                    
                    NavigationLink(destination: Text("Language Settings")) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.green)
                                .frame(width: 30)
                            Text("Language")
                            Spacer()
                            Text("English")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // App Information
                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Help & Support")) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.orange)
                                .frame(width: 30)
                            Text("Help & Support")
                        }
                    }
                    
                    NavigationLink(destination: Text("Privacy Policy")) {
                        HStack {
                            Image(systemName: "lock.shield")
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            Text("Privacy Policy")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                            .frame(width: 30)
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                }
                
                // Sign Out
                Section {
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
    
    func getInitials(from name: String) -> String {
        let components = name.split(separator: " ")
        let initials = components.compactMap { $0.first }.prefix(2)
        return String(initials).uppercased()
    }
}

struct StatisticRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(title)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
}
