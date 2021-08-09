//
//  EventDetailsViewModel.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol EventDetailsViewModelInput: AnyObject {
    var onViewDidLoad: PublishSubject<Void> { get }
    var onCoordinatesRequested: PublishSubject<Void> { get }
}

protocol EventDetailsViewModelOutput: AnyObject {
    var eventDetails: Driver<EventDetailsViewModel.EventDisplay> { get }
    var coordinate: Driver<EventDetailsViewModel.Coordinate> { get }
}

protocol EventDetailsViewModelType: AnyObject {
    var input: EventDetailsViewModelInput { get }
    var output: EventDetailsViewModelOutput { get }
}

final class EventDetailsViewModel: EventDetailsViewModelType, EventDetailsViewModelInput, EventDetailsViewModelOutput {
    
    var eventDetails: Driver<EventDisplay>
    var coordinate: Driver<Coordinate>
    
    init(interactor: EventDetailsInteractable, event: Event) {
        eventDetails = onViewDidLoad.asDriverOnErrorJustComplete()
            .map { _ in
                EventDisplay(
                    title: event.title,
                    description: event.description,
                    price: event.price.currencyFormatted(),
                    date: event.date.timestampToDate.formatted(using: .compacted),
                    imageURL: event.imageURL
                )
            }
        
        coordinate = onCoordinatesRequested.asDriverOnErrorJustComplete()
            .map { _ in
                Coordinate(
                    longitud: event.longitude,
                    latitude: event.latitude
                )
            }
    }
    
    var onViewDidLoad: PublishSubject<Void> = PublishSubject()
    var onCoordinatesRequested: PublishSubject<Void> = PublishSubject()

    var input: EventDetailsViewModelInput { return self }
    var output: EventDetailsViewModelOutput { return self }

}

extension EventDetailsViewModel {
    struct EventDisplay: Equatable {
        let title: String
        let description: String
        let price: String
        let date: String
        let imageURL: String
    }
    
    struct Coordinate: Equatable {
        let longitud: Double
        let latitude: Double
    }
}
