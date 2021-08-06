//
//  Int.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//

import Foundation

extension Int {
    var timestampToDate: Date {
        let timeInt = TimeInterval(self)
        return Date(timeIntervalSince1970: timeInt)
    }
}
