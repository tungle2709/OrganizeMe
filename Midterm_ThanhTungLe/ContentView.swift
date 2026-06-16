//
//  ContentView.swift
//  Midterm_ThanhTungLe
//
//  Created by Tung Le on 16/6/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            TodoListView()
                .tabItem {
                    Label("To-Do", systemImage: "checklist")
                }
            
            FinanceView()
                .tabItem {
                    Label("Finance", systemImage: "dollarsign.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(viewModel)
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
