//
//  ContentView.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    private let username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    private let moods: [String] = ["😎", "🙂", "😌", "😐", "😖", "😡", "🙁", "😢"]
    private let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Welcome, \(username)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.primary))
                        .padding(.bottom)
                    
                    moodView
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

extension ContentView {
    
    internal var moodView: some View {
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
                
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach(moods, id: \.self) { mood in
                    if let image = mood.emojiToImage() {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 65)
                            .onTapGesture {
                                
                            }
                    }
                }
            }
        }
    }
    
}

extension String {
    func emojiToImage() -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 60)
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
 
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
 
        return image
    }
}
