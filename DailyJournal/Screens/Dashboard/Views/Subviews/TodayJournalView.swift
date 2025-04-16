//
//  TodayJournalView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct TodayJournalView: View {
    var journal: Journal?
    
    var body: some View {
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

#Preview {
    TodayJournalView()
}
