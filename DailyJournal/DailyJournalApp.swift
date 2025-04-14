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
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootView: View {
    private let hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

    var body: some View {
        if hasSeenOnboarding {
            ContentView()
        } else {
            OnboardingView()
        }
    }
}
