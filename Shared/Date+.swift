//
//  Date+.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-11.
//

import Foundation
import SwiftUI

extension String {
    var date: Date? {
        ISO8601DateFormatter().date(from: self)
    }
}

extension Date {
    var relative: String {
        relative()
    }

    var relativeAttributed: AttributedString {
        var result = AttributedString(relative)
        result.foregroundColor = relativeColor
        return result
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
            ("hours", "h"),
            ("hour", "h"),
            ("minutes", "m"),
            ("minute", "m"),
            (" ", ""),
            ("ago", "")
        ]

        var string = RelativeDateTimeFormatter().localizedString(for: self, relativeTo: date)
        transformations.forEach { string = string.replacingOccurrences(of: $0.0, with: $0.1) }
        return string
    }

    var relativeColor: Color? {
        let transformations: [(String, Color)] = [
            ("y", .red),
            ("M", .purple),
            ("w", .brown),
            ("d", .orange),
            ("h", .yellow),
            ("m", .green)
        ]

        return transformations.first { relative.contains($0.0) }?.1
    }
}
