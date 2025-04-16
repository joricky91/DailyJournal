//
//  ContentView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Binding var username: String
    @State internal var hideMoodView: Bool = false
    @State private var shouldNavigate = false
    @State private var selectedIndex: Int = 0
    
    @Environment(\.modelContext) var modelContext
    
    @State private var journal: Journal?
    @State private var weeklyJournals: [Journal] = []
    private let moods = MoodData.moods
    
    init(username: Binding<String>) {
        self._username = username
    }
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(uiImage: .strokedCheckmark)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        
                        Text("Welcome, ")
                            .font(.headline)
                            
                        Text(username)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.primary))
                            .padding(.bottom, Constant.paddingBottom)
                        
                        if !hideMoodView {
                            MoodView(selectedIndex: $selectedIndex,
                                     shouldNavigate: $shouldNavigate)
                                .padding(.bottom, Constant.paddingBottom)
                        }
                        
                        TodayJournalView(journal: journal)
                            .padding(.bottom)
                        
                        WeeklyJournalView(weeklyJournals: weeklyJournals)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden()
        }
        .fullScreenCover(isPresented: $shouldNavigate) {
            getTodayJournal()
            getWeeklyJournal()
        } content: {
            JournalLogView(mood: moods[selectedIndex].image,
                           moodString: moods[selectedIndex].mood,
                           moodColor: moods[selectedIndex].color)
        }
        .onAppear {
            getTodayJournal()
            getWeeklyJournal()
        }
    }
    
    func getWeeklyJournal() {
        let calendar = Calendar(identifier: .gregorian)
        let startOfWeek = Date().startOfWeek(using: calendar)
        let startOfNextWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        let predicate = #Predicate<Journal> {
            $0.date >= startOfWeek && $0.date < startOfNextWeek
        }
        
        weeklyJournals = SwiftDataManager.shared.fetchAll(context: modelContext, predicate: predicate)
    }
    
    func getTodayJournal() {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!
        let predicate = #Predicate<Journal> {
            $0.date >= startOfToday && $0.date < startOfTomorrow
        }
        
        journal = SwiftDataManager.shared.fetchOne(context: modelContext, predicate: predicate)
        if let _ = journal { hideMoodView = true } else { hideMoodView = false }
    }
}

#Preview {
    @Previewable @State var username: String = "Ricky"
    ContentView(username: $username)
        .modelContainer(for: Journal.self, inMemory: true)
}
