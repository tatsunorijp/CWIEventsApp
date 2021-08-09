//
//  EventsViewModelTests.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CWIEventsApp
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class EventsViewModelTests: XCTestCase {
    private var sut: EventsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: EventsInteractableMock!
    
    private var events: TestableObserver<[EventsViewModel.EventsDisplay]>!
    private var selectedEvent: TestableObserver<CWIEventsApp.Event>!
    private var isLoading: TestableObserver<Bool>!
    private var error: TestableObserver<Error>!
    
    override func setUp() {
        super.setUp()
        setupEventsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func setupEventsViewModel() {
        disposeBag = DisposeBag()
        interactor = EventsInteractableMock()
        sut = EventsViewModel(interactor: interactor)
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        events = testScheduler.createObserver([EventsViewModel.EventsDisplay].self)
        sut.output.events.drive(events).disposed(by: disposeBag)
        
        selectedEvent = testScheduler.createObserver(CWIEventsApp.Event.self)
        sut.output.selectedEvent.drive(selectedEvent).disposed(by: disposeBag)
        
        isLoading = testScheduler.createObserver(Bool.self)
        sut.output.isLoading.drive(isLoading).disposed(by: disposeBag)
        
        error = testScheduler.createObserver(Error.self)
        sut.output.error.drive(error).disposed(by: disposeBag)
        
    }
    
    func test_isLoadingShouldToggle() {
        interactor.getEventsReturnValue = .just([])
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(isLoading.events.compactMap { $0.value.element }, [false, true, false])
    }
    
    func test_errorShouldReturn() {
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        interactor.getEventsReturnValue = .error(expectedError)
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(error.events.compactMap { $0.value.element as NSError? }, [expectedError])
    }
    
    func test_eventsShouldReturn_with_correctFormat() {
        interactor.getEventsReturnValue = .just(EventsViewModelTests.eventsMock)
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(events.events.compactMap { $0.value.element }, [
            [EventsViewModel.EventsDisplay(id: "1",
                                           title: "1",
                                           price: 1.currencyFormatted(),
                                           imageURL: "1",
                                           date: "20 de agosto"),
             EventsViewModel.EventsDisplay(id: "2",
                                           title: "2",
                                           price: 2.currencyFormatted(),
                                           imageURL: "2",
                                           date: "20 de agosto"),
             EventsViewModel.EventsDisplay(id: "3",
                                           title: "3",
                                           price: 3.currencyFormatted(),
                                           imageURL: "3",
                                           date: "20 de agosto")
            ]
        ])
    }
    
    func test_shouldSelectedEvent_return() {
        interactor.getEventsReturnValue = .just(EventsViewModelTests.eventsMock)
        sut.input.onViewDidLoad.onNext(())
        sut.input.onSelectEventId.onNext("1")
        
        XCTAssertEqual(selectedEvent.events.compactMap { $0.value.element }, [EventsViewModelTests.eventsMock[0]])
    }
}

extension EventsViewModelTests {
    static let eventsMock = [
        CWIEventsApp.Event(
            people: [],
            date: 1_534_784_400,
            description: "1",
            imageURL: "1",
            longitude: 1,
            latitude: 1,
            price: 1,
            title: "1",
            id: "1"
        ),
        CWIEventsApp.Event(
            people: [],
            date: 1_534_784_400,
            description: "2",
            imageURL: "2",
            longitude: 2,
            latitude: 2,
            price: 2,
            title: "2",
            id: "2"
        ),
        CWIEventsApp.Event(
            people: [],
            date: 1_534_784_400,
            description: "3",
            imageURL: "3",
            longitude: 3,
            latitude: 3,
            price: 3,
            title: "3",
            id: "3"
        )
    ]
}
