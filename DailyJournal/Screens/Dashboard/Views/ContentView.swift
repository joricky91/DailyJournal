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
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = DashboardViewModel()
    
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
                            Image(.appLogo)
                                .resizable()
                                .frame(width: 50, height: 80)
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        
                        WelcomeTitleView(username: username)
                        
                        if !viewModel.hideMoodView {
                            MoodView(selectedIndex: $viewModel.selectedIndex,
                                     shouldNavigate: $viewModel.shouldNavigate)
                                .padding(.bottom, Constant.paddingBottom)
                        }
                        
                        TodayJournalView(journal: viewModel.journal)
                            .padding(.bottom)
                        
                        WeeklyJournalView(weeklyJournals: viewModel.weeklyJournals)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden()
        }
        .fullScreenCover(isPresented: $viewModel.shouldNavigate) {
            viewModel.onAppear(modelContext: modelContext)
        } content: {
            JournalLogView(mood: moods[viewModel.selectedIndex].image,
                           moodString: moods[viewModel.selectedIndex].mood,
                           moodColor: moods[viewModel.selectedIndex].color)
        }
        .onAppear {
            viewModel.onAppear(modelContext: modelContext)
        }
    }
}

#Preview {
    @Previewable @State var username: String = "Ricky"
    ContentView(username: $username)
        .modelContainer(for: Journal.self, inMemory: true)
}
