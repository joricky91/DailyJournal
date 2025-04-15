//
//  ContentView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import SwiftUI
import SwiftData

struct Mood {
    var image: String
    var mood: String
    var color: Color
}

struct ContentView: View {

    @Binding var username: String
    @State internal var hideMoodView: Bool = false
    @State private var shouldNavigate = false
    @State private var selectedIndex: Int = 0
    
    @Environment(\.modelContext) var modelContext
    
    private let moods: [Mood] = [Mood(image: "😎", mood: "Joyful", color: .green), Mood(image: "🙂", mood: "Happy", color: .yellow), Mood(image: "😌", mood: "Calm", color: .pink), Mood(image: "😐", mood: "Flat", color: .gray), Mood(image: "😖", mood: "Not Good", color: .orange) ,Mood(image: "😡", mood: "Angry", color: .red), Mood(image: "🙁", mood: "Sad", color: .blue), Mood(image: "😢", mood: "Very Sad", color: .blue)]
    
    private let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    private let paddingBottom: CGFloat = UIScreen.main.bounds.height / 30
    
    @State private var journal: Journal?
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            NavigationStack {
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
                        .padding(.bottom, paddingBottom)
                    
                    if !hideMoodView {
                        moodView
                            .padding(.bottom, paddingBottom)
                    }
                    
                    todayJournalView
                    
                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $shouldNavigate) {
                    JournalLogView(mood: moods[selectedIndex].image,
                                   moodString: moods[selectedIndex].mood,
                                   moodColor: moods[selectedIndex].color)
                }
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            let startOfToday = Calendar.current.startOfDay(for: Date())
            let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!

            let predicate = #Predicate<Journal> {
                $0.date >= startOfToday && $0.date < startOfTomorrow
            }
            
            journal = SwiftDataManager.shared.fetchOne(context: modelContext, predicate: predicate)
            
            if let journal { hideMoodView = true } else { hideMoodView = false }
        }
    }
}

#Preview {
    @Previewable @State var username: String = "Ricky"
    ContentView(username: $username)
        .modelContainer(for: Item.self, inMemory: true)
}

extension ContentView {
    
    internal var moodView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    let date = Date()
                    Text(date, format: .dateTime)
                        .font(.headline)
                        .foregroundStyle(Color(.secondaryText))
                    
                    Text("How are you feeling today?")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        hideMoodView = true
                    }
            }
            
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach(0..<moods.count, id: \.self) { index in
                    if let image = moods[index].image.emojiToImage() {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 65)
                            .onTapGesture {
                                selectedIndex = index
                                shouldNavigate = true
                            }
                    }
                }
            }
        }
    }
    
    internal var todayJournalView: some View {
        VStack(alignment: .leading) {
            Text("Today's Journal")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(.primary))
            
            if let journal {
                VStack(alignment: .leading) {
                    HStack {
                        if let image = journal.mood.emojiToImage() {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 60, height: 65)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(Date(), format: .dateTime)
                                .font(.caption)
                                .foregroundStyle(.secondaryText)
                            
                            Text(journal.moodName)
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                    }
                    
                    Text(journal.moodDescription)
                }
            } else {
                ContentUnavailableView("No Journal",
                                       systemImage: "book.pages",
                                       description: Text("You haven't log your journal today! Log it above!"))
                .frame(height: UIScreen.main.bounds.height / 4)
            }
        }
    }
    
}
