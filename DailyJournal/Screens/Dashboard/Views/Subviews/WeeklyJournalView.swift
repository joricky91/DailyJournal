//
//  WeeklyJournalView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI

struct WeeklyJournalView: View {
    var weeklyJournals: [Journal] = []
    
    private let days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekly Journal")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(.primary))
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(0..<days.count, id: \.self) { index in
                        VStack(alignment: .center) {
                            Text(days[index])
                                .font(.title3)
                            
                            HomeIconView(weeklyJournals: weeklyJournals, index: index)
                        }
                        .padding(8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.secondaryText), lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WeeklyJournalView()
}
