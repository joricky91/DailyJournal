//
//  DashboardViewModel.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation
import SwiftData

class DashboardViewModel: ObservableObject {
    
    @Published var hideMoodView: Bool = false
    @Published var shouldNavigate = false
    @Published var selectedIndex: Int = 0
    @Published var journal: Journal?
    @Published var weeklyJournals: [Journal] = []
    
    func onAppear(modelContext: ModelContext) {
        getTodayJournal(modelContext: modelContext)
        getWeeklyJournal(modelContext: modelContext)
    }
    
    private func getWeeklyJournal(modelContext: ModelContext) {
        let calendar = Calendar(identifier: .gregorian)
        let startOfWeek = Date().startOfWeek(using: calendar)
        let startOfNextWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        let predicate = #Predicate<Journal> {
            $0.date >= startOfWeek && $0.date < startOfNextWeek
        }
        
        weeklyJournals = SwiftDataManager.shared.fetchAll(context: modelContext, predicate: predicate)
    }
    
    private func getTodayJournal(modelContext: ModelContext) {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!
        let predicate = #Predicate<Journal> {
            $0.date >= startOfToday && $0.date < startOfTomorrow
        }
        
        journal = SwiftDataManager.shared.fetchOne(context: modelContext, predicate: predicate)
        
        if let _ = journal {
            hideMoodView = true
        } else {
            hideMoodView = false
        }
    }
    
}
