//
//  CheckInInteractorTests.swift
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

final class CheckInInteractorTests: XCTestCase {
    private var sut: CheckInInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupCheckInInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupCheckInInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
