// Generated using Sourcery 1.4.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// Template copiado de:
// https://github.com/krzysztofzablocki/Sourcery
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import RxSwift
#elseif os(OSX)
import AppKit
#endif
















class EventDetailsInteractableMock: EventDetailsInteractable {

}
class EventsInteractableMock: EventsInteractable {

    //MARK: - getEvents

    var getEventsCallsCount = 0
    var getEventsCalled: Bool {
        return getEventsCallsCount > 0
    }
    var getEventsReturnValue: Single<[Event]>!
    var getEventsClosure: (() -> Single<[Event]>)?

    func getEvents() -> Single<[Event]> {
        getEventsCallsCount += 1
        return getEventsClosure.map({ $0() }) ?? getEventsReturnValue
    }

}
