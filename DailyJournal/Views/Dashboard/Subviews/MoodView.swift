//
//  MoodView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct MoodView: View {
    
    @Binding var selectedIndex: Int
    @Binding var shouldNavigate: Bool
    
    private let moods = MoodData.moods
    
    var body: some View {
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
            }
            
            LazyVGrid(columns: Constant.gridItems, spacing: 0) {
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
}
//
//#Preview {
//    MoodView()
//}
