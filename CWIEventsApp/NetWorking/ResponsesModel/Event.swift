//
//  Events.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//

import Foundation

struct Event: Codable, Equatable {
    let people: [Person]
    let date: Int
    let description: String
    let imageURL: String
    let longitude, latitude, price: Double
    let title, id: String

    enum CodingKeys: String, CodingKey {
        case people, date
        case description
        case imageURL = "image"
        case longitude, latitude, price, title, id
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Person
struct Person: Codable {
    let id, eventID, name, picture: String

    enum CodingKeys: String, CodingKey {
        case id
        case eventID = "eventId"
        case name, picture
    }
}
