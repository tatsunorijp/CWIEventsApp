//
//  Double.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//

import Foundation

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        return formatter
    }()
}

extension Double {
    func currencyFormatted(using formatter: NumberFormatter = .currency) -> String {
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
