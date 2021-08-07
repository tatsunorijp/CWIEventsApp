//
//  EventsViewModel.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol EventsViewModelInput: AnyObject {
    var onViewDidLoad: PublishSubject<Void> { get }
    var onSelectEventId: PublishSubject<String> { get }
}

protocol EventsViewModelOutput: AnyObject {
    var events: Driver<[EventsViewModel.EventsDisplay]> { get }
    var selectedEvent: Driver<Event> { get }
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol EventsViewModelType: AnyObject {
    var input: EventsViewModelInput { get }
    var output: EventsViewModelOutput { get }
}

final class EventsViewModel: EventsViewModelType, EventsViewModelInput, EventsViewModelOutput {
    
    var events: Driver<[EventsDisplay]>
    var selectedEvent: Driver<Event>
    var isLoading: Driver<Bool>
    var error: Driver<Error>
    
    init(interactor: EventsInteractable) {
        let activityTracker = ActivityIndicator()
        let errorTracker = ErrorTracker()
        isLoading = activityTracker.asDriver()
        error = errorTracker.asDriver()
        
        let fetchedEvents = onViewDidLoad.asDriverOnErrorJustComplete()
            .flatMap { _ in
                interactor.getEvents()
                    .asDriver(trackActivityWith: activityTracker, onErrorTrackWith: errorTracker)
            }
        
        events = fetchedEvents
            .map { $0.map { event in
                return EventsDisplay(
                    id: event.id,
                    title: event.title,
                    price: event.price.currencyFormatted(),
                    imageURL: event.imageURL,
                    date: event.date.timestampToDate.formatted(using: .dayMonthShort)
                )
            }}
        
        selectedEvent = onSelectEventId.asDriverOnErrorJustComplete()
            .withLatestFrom(fetchedEvents) { (selectedId: $0, events: $1) }
            .map { selectedId, events in
                return events.first(where: { $0.id == selectedId })!
            }
    }
    
    var onViewDidLoad: PublishSubject<Void> = PublishSubject()
    var onSelectEventId: PublishSubject<String> = PublishSubject()
    
    var input: EventsViewModelInput { return self }
    var output: EventsViewModelOutput { return self }
}

extension EventsViewModel {
    struct EventsDisplay: Equatable {
        let id: String
        let title: String
        let price: String
        let imageURL: String
        let date: String
    }
}
