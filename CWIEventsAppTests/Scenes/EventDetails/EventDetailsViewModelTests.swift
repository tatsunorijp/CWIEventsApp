//
//  EventDetailsViewModelTests.swift
//  CWIEventsApp
//
//  Created by Tatsu on 09/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CWIEventsApp
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class EventDetailsViewModelTests: XCTestCase {
    private var sut: EventDetailsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: EventDetailsInteractableMock!
    
    private var eventDetails: TestableObserver<EventDetailsViewModel.EventDisplay>!
    private var coordinate: TestableObserver<EventDetailsViewModel.Coordinate>!
    var eventIDToCheckIn: TestableObserver<String>!
    
    override func setUp() {
        super.setUp()
        setupEventDetailsViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupEventDetailsViewModel() {
        disposeBag = DisposeBag()
        interactor = EventDetailsInteractableMock()
        sut = EventDetailsViewModel(
            interactor: interactor,
            event: CWIEventsApp.Event(
                people: [],
                date: 1_534_784_400,
                description: "1",
                imageURL: "1",
                longitude: 1,
                latitude: 1,
                price: 1,
                title: "1",
                id: "1"
            )
        )
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        eventDetails = testScheduler.createObserver(EventDetailsViewModel.EventDisplay.self)
        sut.output.eventDetails.drive(eventDetails).disposed(by: disposeBag)
        
        coordinate = testScheduler.createObserver(EventDetailsViewModel.Coordinate.self)
        sut.output.coordinate.drive(coordinate).disposed(by: disposeBag)
        
        eventIDToCheckIn = testScheduler.createObserver(String.self)
        sut.output.eventIDToCheckIn.drive(eventIDToCheckIn).disposed(by: disposeBag)
        
    }

    func test_shouldEventDetailsReturn_with_correctFormat() {
        sut.input.onViewDidLoad.onNext(())
        XCTAssertEqual(eventDetails.events.compactMap { $0.value.element }, [
            EventDetailsViewModel.EventDisplay(
                title: "1",
                description: "1",
                price: 1.currencyFormatted(),
                date: "20/08/2018",
                imageURL: "1"
            )
        ])
    }
    
    func test_shouldCoordinateReturn() {
        sut.input.onCoordinatesRequested.onNext(())
        XCTAssertEqual(coordinate.events.compactMap { $0.value.element }, [
            EventDetailsViewModel.Coordinate(
                longitud: 1,
                latitude: 1
            )
        ])
    }
    
    func test_eventIDTocheckInShouldReturn() {
        sut.input.onViewDidLoad.onNext(())
        sut.input.onCheckInChange.onNext(())
        
        XCTAssertEqual(eventIDToCheckIn.events.compactMap { $0.value.element }, ["1"])
    }
}
