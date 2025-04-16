//
//  HomeIconView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI

struct HomeIconView: View {
    var weeklyJournals: [Journal] = []
    var index: Int = 0
    
    var body: some View {
        VStack {
            if weeklyJournals.indices.contains(index) {
                let image = weeklyJournals[index].getImage()
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 24, height: 24)
            } else {
                Circle()
                    .fill(.red)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

#Preview {
    HomeIconView()
}
