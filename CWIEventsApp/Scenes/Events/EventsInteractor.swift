//
//  EventsInteractor.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

// sourcery: AutoMockable
protocol EventsInteractable: AnyObject {
    func getEvents() -> Single<[Event]>
}

final class EventsInteractor: EventsInteractable {
    func getEvents() -> Single<[Event]> {
        return ApiClient.getEvents().asSingle()
    }
}
