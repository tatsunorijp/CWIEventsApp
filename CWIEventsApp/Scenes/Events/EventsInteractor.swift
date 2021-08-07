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
        
//        let eventsMock = [
//            Event(
//                people: [],
//                date: 1,
//                description: "1",
//                image: "",
//                longitude: 0,
//                latitude: 0,
//                price: 0,
//                title: "1",
//                id: "1"
//            ),
//            Event(
//                people: [],
//                date: 2,
//                description: "2",
//                image: "",
//                longitude: 0,
//                latitude: 0,
//                price: 0,
//                title: "2",
//                id: "2"
//            ),
//            Event(
//                people: [],
//                date: 3,
//                description: "3",
//                image: "",
//                longitude: 0,
//                latitude: 0,
//                price: 0,
//                title: "3",
//                id: "3"
//            )
//        ]
//
//        return Single.just(Events(events: eventsMock))
//            .delay(.seconds(2), scheduler: MainScheduler.instance)
    }
}
