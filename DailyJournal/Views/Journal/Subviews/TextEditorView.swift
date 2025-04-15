//
//  TextEditorView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct TextEditorView: View {
    var title: String = ""
    var strokeColor: Color = .accentColor
    @Binding var moodDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Describe your day here")
            
            TextEditor(text: $moodDescription)
                .frame(height: 120)
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(strokeColor, lineWidth: 1)
                )
        }
        .padding()
    }
}

//#Preview {
//    TextEditorView()
//}
