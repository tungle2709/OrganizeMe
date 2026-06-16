# Organize App

A SwiftUI-based organize and planner application for managing your calendar, tasks, and finances in one place.

## Features

- **Home Dashboard** - Overview of your events, tasks, and financial balance
- **Calendar** - Schedule and manage events with an interactive date picker
- **To-Do List** - Track tasks with priority levels and completion status
- **Finance Tracker** - Monitor income and expenses with transaction history
- **Profile** - View statistics and manage app settings

## Setup Instructions

### Requirements
- Xcode 14.0 or later
- iOS 15.0 or later
- macOS 12.0 or later

### Installation

1. **Clone or download the project**
   ```
   Open the project folder in Finder
   ```

2. **Open the project in Xcode**
   - Double-click `Midterm_ThanhTungLe.xcodeproj`
   - Wait for Xcode to load the project

3. **Select a simulator**
   - Click on the device selector in the toolbar
   - Choose any iPhone simulator (iPhone 14, 15, or 16 recommended)

4. **Build and run**
   - Press `Cmd + R` or click the Run button
   - Wait for the app to build and launch in the simulator

### First Launch

The app includes sample data to help you explore its features:
- 2 calendar events
- 3 to-do items
- 3 financial transactions

## How to Use

### Adding Events
1. Tap the **Calendar** tab
2. Tap the **+** button
3. Fill in event details (title, date, time, category)
4. Tap **Save**

### Adding Tasks
1. Tap the **To-Do** tab
2. Tap the **+** button
3. Enter task details and select priority
4. Tap **Save**

### Adding Transactions
1. Tap the **Finance** tab
2. Tap the **+** button
3. Choose income or expense type
4. Enter amount and details
5. Tap **Save**

## Technology Stack

- **SwiftUI** - Modern declarative UI framework
- **Combine** - Reactive data flow
- **MVVM Architecture** - Clean separation of concerns

## Project Structure

```
Midterm_ThanhTungLe/
├── Models/          # Data models
├── ViewModels/      # Business logic
├── Views/           # UI screens
└── Assets/          # Images and colors
```

## Support

For issues or questions, please check the code comments or review the implementation details in the source files.
