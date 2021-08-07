//
//  EventsInteractorTests.swift
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

final class EventsInteractorTests: XCTestCase {
    private var sut: EventsInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupEventsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupEventsInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
