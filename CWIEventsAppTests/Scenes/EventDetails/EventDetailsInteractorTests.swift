//
//  EventDetailsInteractorTests.swift
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

final class EventDetailsInteractorTests: XCTestCase {
    private var sut: EventDetailsInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupEventDetailsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupEventDetailsInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
