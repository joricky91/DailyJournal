//
//  Date+Ext.swift
//  DailyJournal
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.date(from: calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self))!
    }
}
