//
//  Item.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
