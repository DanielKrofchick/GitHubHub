//
//  Date+.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-11.
//

import Foundation

extension String {
    var date: Date? {
        ISO8601DateFormatter().date(from: self)
    }
}

extension Date {
    var relative: String {
        relative()
    }

    func relative(to date: Date = Date()) -> String {
        let transformations = [
            ("years", "y"),
            ("year", "y"),
            ("months", "M"),
            ("month", "M"),
            ("weeks", "w"),
            ("week", "w"),
            ("days", "d"),
            ("day", "d"),
            ("minutes", "m"),
            ("minute", "m"),
            ("hours", "h"),
            ("hour", "h"),
            (" ", ""),
            ("ago", "")
        ]

        var string = RelativeDateTimeFormatter().localizedString(for: self, relativeTo: date)
        transformations.forEach { string = string.replacingOccurrences(of: $0.0, with: $0.1) }
        return string
    }
}
