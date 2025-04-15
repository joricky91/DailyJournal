//
//  Journal.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 15/04/25.
//

import Foundation
import SwiftData

@Model
final class Journal {
    var mood: String
    var moodName: String
    var moodDescription: String
    var date: Date
    
    init(mood: String, moodName: String, moodDescription: String, date: Date) {
        self.mood = mood
        self.moodName = moodName
        self.moodDescription = moodDescription
        self.date = date
    }
}
