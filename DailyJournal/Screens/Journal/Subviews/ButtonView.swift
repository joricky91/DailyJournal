//
//  ButtonView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct ButtonView: View {
    var buttonText: String = ""
    var isTransparent: Bool = false
    var buttonAction: (() -> Void)?
    
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(buttonText)
                .foregroundColor(Color(.primary))
                .frame(maxWidth: .infinity)
                .padding()
                .background(isTransparent ? .clear : Color.accentColor)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ButtonView()
}
