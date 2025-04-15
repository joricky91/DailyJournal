//
//  Mood.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import SwiftUI

struct Mood {
    var image: String
    var mood: String
    var color: Color
}

struct MoodData {
    static let moods: [Mood] = [Mood(image: "😎", mood: "Joyful", color: .green), Mood(image: "🙂", mood: "Happy", color: .yellow), Mood(image: "😌", mood: "Calm", color: .pink), Mood(image: "😐", mood: "Flat", color: .gray), Mood(image: "😖", mood: "Not Good", color: .orange) ,Mood(image: "😡", mood: "Angry", color: .red), Mood(image: "🙁", mood: "Sad", color: .blue), Mood(image: "😢", mood: "Very Sad", color: .blue)]
}
