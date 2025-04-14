//
//  OnboardingView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import SwiftUI

struct OnboardingView: View {
//    @AppStorage("userName") var userName: String = ""
//    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var shouldNavigate = false
    @State private var username: String = ""
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    VStack(alignment: .center) {
                        Text("Let’s get to know you!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.primary))
                            .padding(.bottom, 12)
                        
                        Text("Please enter your name so this app feels more personal to you.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondaryText)
                        
                        TextField("Enter your name", text: $username)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.accent, lineWidth: 1)
                            )
                    }
                    .padding(.bottom, UIScreen.main.bounds.width / 10)
                    
                    Button {
                        if !username.trimmingCharacters(in: .whitespaces).isEmpty {
                            UserDefaults.standard.set(username, forKey: "username")
                            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.shouldNavigate = true
                            }
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(Color(.primary))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width / 7)
                }
                .padding()
                .navigationDestination(isPresented: $shouldNavigate) {
                    ContentView()
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
