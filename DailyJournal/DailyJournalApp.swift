//
//  DailyJournalApp.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import SwiftUI
import SwiftData

@main
struct DailyJournalApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @AppStorage("username") var username = ""
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView(hasSeenOnboarding: $hasSeenOnboarding, username: $username)
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootView: View {
    @Binding var hasSeenOnboarding: Bool
    @Binding var username: String

    var body: some View {
        if hasSeenOnboarding {
            ContentView(username: $username)
        } else {
            OnboardingView(username: $username, hasSeenOnboarding: $hasSeenOnboarding)
        }
    }
}
