//
//  JournalLogView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI
import SwiftData

struct JournalLogView: View {
    var mood: String = "😎"
    var moodString: String = "Joyful"
    var moodColor: Color = .green
    
    @State private var moodDescription: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
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
            
            TextEditorView(title: "Describe yoyr day here",
                           strokeColor: moodColor,
                           moodDescription: $moodDescription)
            
            Spacer()
            
            ButtonView(buttonText: "Save", isTransparent: false) {
                let newJournal = Journal(mood: mood,
                                         moodName: moodString,
                                         moodDescription: moodDescription,
                                         date: Date())
                SwiftDataManager.shared.addToLocal(context: modelContext, data: newJournal)
                dismiss()
            }
            
            ButtonView(buttonText: "Cancel", isTransparent: true) {
                dismiss()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JournalLogView()
}
