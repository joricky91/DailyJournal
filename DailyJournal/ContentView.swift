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
    
    private let moods: [String] = ["😎", "🙂", "😌", "😐", "😖", "😡", "🙁", "😢"]
    private let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    private let paddingBottom: CGFloat = UIScreen.main.bounds.height / 30
    
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
            }
            .navigationBarBackButtonHidden()
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
                ForEach(moods, id: \.self) { mood in
                    if let image = mood.emojiToImage() {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 65)
                            .onTapGesture {
                                
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
            
//                        ContentUnavailableView("No Journal",
//                                               systemImage: "book.pages",
//                                               description: Text("You haven't log your journal today! Log it above!"))
//                        .frame(height: UIScreen.main.bounds.height / 4)
            
            VStack(alignment: .leading) {
                HStack {
                    if let image = moods[0].emojiToImage() {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 65)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(Date(), format: .dateTime)
                            .font(.caption)
                            .foregroundStyle(.secondaryText)
                        
                        Text("Joyful")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in placerat eros. Duis dignissim nulla mi, nec commodo urna sagittis eu. Phasellus sagittis, quam at facilisis fermentum, orci orci vestibulum libero, nec condimentum leo purus vel ante. Donec a nibh non enim vehicula tristique. Sed at interdum risus.")
            }
        }
    }
    
}
