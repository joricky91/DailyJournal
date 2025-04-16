//
//  WelcomeTitleView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI

struct WelcomeTitleView: View {
    var username: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome, ")
                .font(.headline)
                
            Text(username)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(.primary))
                .padding(.bottom, Constant.paddingBottom)
        }
    }
}

#Preview {
    WelcomeTitleView()
}
