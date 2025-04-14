//
//  User.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 14/04/25.
//

import Foundation
import SwiftData

@Model
final class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
