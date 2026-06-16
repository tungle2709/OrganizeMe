# Organize App - iOS Midterm Project
**Author:** Thanh Tung Le  
**Course:** PROG39856 Advanced Mobile iOS App Development  
**Date:** June 16, 2026

## Overview
A comprehensive SwiftUI-based organize/planner application with 8+ screens featuring Calendar events, To-Do lists, and Finance tracking functionality.

## Features

### 1. **Tab-Based Navigation**
- Tab Bar Controller with 5 main sections:
  - Home (Dashboard)
  - Calendar
  - To-Do List
  - Finance
  - Profile

### 2. **Eight Main Screens**

#### Screen 1: Home View (Dashboard)
- Welcome header with current date
- Quick statistics cards showing:
  - Total events
  - Pending tasks
  - Current balance
  - Completed tasks
- Preview of upcoming events
- Preview of today's tasks
- Navigation links to detailed views

#### Screen 2: Calendar View
- Interactive graphical date picker
- Filter events by selected date
- List of events for the selected date
- Add new event button
- Swipe-to-delete functionality

#### Screen 3: Add Event View
- Form to add new calendar events
- Fields: Title, Date, Time, Category, Notes
- Category picker with predefined options
- Date and time pickers
- Data passed back to Calendar view

#### Screen 4: Event Detail View
- Detailed event information display
- Shows title, date, time, category, and notes
- Clean card-based layout
- System icons for visual clarity

#### Screen 5: To-Do List View
- List view showing all tasks
- Separated sections for pending and completed tasks
- Toggle to show/hide completed tasks
- Priority indicators (High, Medium, Low)
- Tap to toggle completion status
- Swipe-to-delete functionality

#### Screen 6: Add Task View
- Form to create new to-do items
- Fields: Title, Description, Due Date, Priority
- Segmented control for priority selection
- Visual priority indicators
- Data passed back to To-Do List

#### Screen 7: Finance View
- Horizontal scrolling summary cards showing:
  - Total balance
  - Total income
  - Total expenses
- List of all transactions
- Income/expense type indicators
- Swipe-to-delete functionality

#### Screen 8: Add Transaction View
- Form to add financial transactions
- Fields: Title, Amount, Category, Type, Date, Notes
- Segmented control for Income/Expense selection
- Category picker
- Real-time amount preview
- Decimal keyboard for amount entry
- Data passed back to Finance view

#### Screen 9: Profile View (Bonus)
- User profile information
- Statistics summary
- Settings toggles (Notifications, Dark Mode)
- App information and version
- Navigation to additional settings

## Technical Implementation

### Data Models
- **Event**: Stores calendar event information
- **TodoItem**: Stores task information with priority levels
- **Transaction**: Stores financial transaction data with income/expense types

### View Models
- **AppViewModel**: 
  - Central data management using `@Published` properties
  - Observable object pattern for state management
  - CRUD operations for all data types
  - Sample data initialization

### Data Flow
- Uses SwiftUI's `@EnvironmentObject` for sharing data across views
- Child views receive data through environment
- Modal sheets for add/edit operations
- Data persistence through shared view model

### UI Components
- **Lists**: Native SwiftUI List views with ForEach
- **Forms**: Form-based input screens
- **Pickers**: DatePicker, Picker, and segmented controls
- **Cards**: Custom card components with shadows and corner radius
- **Navigation**: NavigationView and NavigationLink
- **Sheets**: Modal presentation for add screens

### Constraints & Layout
- SwiftUI's automatic layout system with:
  - VStack and HStack for vertical/horizontal stacking
  - Spacer() for flexible spacing
  - .frame() modifiers for sizing
  - .padding() for consistent spacing
  - Responsive to different iPhone screen sizes

### Design Features
- Clean, modern interface
- Consistent color scheme (Blue accent color)
- SF Symbols for icons
- Shadow effects for depth
- Corner radius for modern look
- Color-coded elements (priority, transaction type)
- Proper spacing and alignment

## Project Structure
```
Midterm_ThanhTungLe/
├── Midterm_ThanhTungLeApp.swift (App entry point)
├── ContentView.swift (Tab bar controller)
├── Models/
│   ├── Event.swift
│   ├── TodoItem.swift
│   └── Transaction.swift
├── ViewModels/
│   └── AppViewModel.swift
├── Views/
│   ├── HomeView.swift
│   ├── CalendarView.swift
│   ├── AddEventView.swift
│   ├── EventDetailView.swift
│   ├── TodoListView.swift
│   ├── AddTodoView.swift
│   ├── FinanceView.swift
│   ├── AddTransactionView.swift
│   └── ProfileView.swift
└── Assets.xcassets/
```

## Requirements Met

✅ **8+ Screens**: 9 screens implemented  
✅ **SwiftUI**: Entire app built with SwiftUI  
✅ **Data Passing**: Data flows between views via EnvironmentObject  
✅ **List Views**: Used for Calendar events, To-Do items, and Transactions  
✅ **Tab Bar**: Tab-based navigation with 5 tabs  
✅ **Actual UI Elements**: No images used, all native UI components  
✅ **Constraints**: SwiftUI layout system ensures consistency across devices  
✅ **Add Functionality**: Forms to add events, tasks, and transactions  

## How to Run
1. Open `Midterm_ThanhTungLe.xcodeproj` in Xcode
2. Select a simulator (iPhone 14, 15, or 16 recommended)
3. Press Cmd+R to build and run
4. The app includes sample data for demonstration

## Sample Data
The app initializes with sample data including:
- 2 calendar events
- 3 to-do items (2 pending, 1 completed)
- 3 financial transactions (1 income, 2 expenses)

## Testing
The app has been designed to work across different iPhone models using SwiftUI's adaptive layout system.
