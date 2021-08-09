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
//    private var selectedEvent: TestableObserver<Event>!
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
        sut = EventsViewModel(interactor: interactor)
        
        let testScheduler = TestScheduler(initialClock: 0)
    }

    func testExample() {}
}
