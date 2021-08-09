//
//  Strings.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import Foundation

extension String {
    var numberOfWords: Int {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
    
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
