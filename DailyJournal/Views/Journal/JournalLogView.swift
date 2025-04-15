//
//  JournalLogView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct JournalLogView: View {
    var mood: String = "😎"
    var moodString: String = "Joyful"
    var moodColor: Color = .green
    
    @State private var moodDescription: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack {
                Text("How are you feeling today?")
                    .font(.headline)
                
                if let image = mood.emojiToImage() {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120, height: 130)
                }
                
                Text("I feel \(moodString.lowercased())")
                    .font(.title)
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
            .background(moodColor)
            
            VStack(alignment: .leading) {
                Text("Describe your day here")
                
                TextEditor(text: $moodDescription)
                    .frame(height: 120)
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(moodColor, lineWidth: 1)
                    )
            }
            .padding()
            
            Spacer()
            
            Button {
                print(moodDescription)
            } label: {
                Text("Save")
                    .foregroundColor(Color(.primary))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JournalLogView()
}
