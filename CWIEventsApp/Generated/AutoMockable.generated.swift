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
















class CheckInInteractableMock: CheckInInteractable {

    //MARK: - confirmCheckIn

    var confirmCheckInEventIDEmailCompleteNameCallsCount = 0
    var confirmCheckInEventIDEmailCompleteNameCalled: Bool {
        return confirmCheckInEventIDEmailCompleteNameCallsCount > 0
    }
    var confirmCheckInEventIDEmailCompleteNameReceivedArguments: (eventID: String, email: String, completeName: String)?
    var confirmCheckInEventIDEmailCompleteNameReceivedInvocations: [(eventID: String, email: String, completeName: String)] = []
    var confirmCheckInEventIDEmailCompleteNameReturnValue: Single<Void>!
    var confirmCheckInEventIDEmailCompleteNameClosure: ((String, String, String) -> Single<Void>)?

    func confirmCheckIn(eventID: String, email: String, completeName: String) -> Single<Void> {
        confirmCheckInEventIDEmailCompleteNameCallsCount += 1
        confirmCheckInEventIDEmailCompleteNameReceivedArguments = (eventID: eventID, email: email, completeName: completeName)
        confirmCheckInEventIDEmailCompleteNameReceivedInvocations.append((eventID: eventID, email: email, completeName: completeName))
        return confirmCheckInEventIDEmailCompleteNameClosure.map({ $0(eventID, email, completeName) }) ?? confirmCheckInEventIDEmailCompleteNameReturnValue
    }

}
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
