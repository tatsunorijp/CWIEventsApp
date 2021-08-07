//
//  DateFormatter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 13/07/21.
//

import Foundation

extension DateFormatter {
    static func with(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = enUsLocale
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter
    }
    
    static let enUsLocale = Locale(identifier: "pt_BR")

    static let compacted = DateFormatter.with(format: "dd/MM/yyyy")
    static let dayMonthShort = DateFormatter.with(format: "dd 'de' MMMM")

}
