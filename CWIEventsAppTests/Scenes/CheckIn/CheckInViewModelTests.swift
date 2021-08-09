//
//  CheckInViewModelTests.swift
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

final class CheckInViewModelTests: XCTestCase {
    private var sut: CheckInViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: CheckInInteractableMock!
    
    private var isCheckInEnable: TestableObserver<Bool>!
    private var onCheckinCompleted: TestableObserver<Void>!
    private var isLoading: TestableObserver<Bool>!
    private var error: TestableObserver<Error>!
    
    override func setUp() {
        super.setUp()
        setupCheckInViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupCheckInViewModel() {
        disposeBag = DisposeBag()
        interactor = CheckInInteractableMock()
        sut = CheckInViewModel(interactor: interactor, eventID: "1")
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        isCheckInEnable = testScheduler.createObserver(Bool.self)
        sut.output.isCheckInEnable.drive(isCheckInEnable).disposed(by: disposeBag)
        
        onCheckinCompleted = testScheduler.createObserver(Void.self)
        sut.output.onCheckinCompleted.drive(onCheckinCompleted).disposed(by: disposeBag)
        
        isLoading = testScheduler.createObserver(Bool.self)
        sut.output.isLoading.drive(isLoading).disposed(by: disposeBag)
        
        error = testScheduler.createObserver(Error.self)
        sut.output.error.drive(error).disposed(by: disposeBag)
        
    }

    func test_shouldIsCheckInEnableToggle() {
        sut.input.didCompleteNameChange.onNext("wellington")
        sut.input.didEmailChange.onNext("tatsu@gmail.com")
        sut.input.didEmailChange.onNext("tatsu@gmail.c")
        sut.input.didCompleteNameChange.onNext("")
        sut.input.didCompleteNameChange.onNext("tatsu")
        sut.input.didEmailChange.onNext("tatsu@gmail.co")
        
        XCTAssertEqual(isCheckInEnable.events.compactMap { $0.value.element }, [false, true, false, true])
    }
    
    func test_ShouldOnCheckInCompletedReturn() {
            interactor.confirmCheckInEventIDEmailCompleteNameReturnValue = .just(())
            sut.input.didCompleteNameChange.onNext("wellington")
            sut.input.didEmailChange.onNext("tatsu@gmail.com")
            sut.input.didConfirmCheckIn.onNext(())
            
        XCTAssertEqual(onCheckinCompleted.events.compactMap { $0.value.element }.count, 1)
    }
    
    func test_shouldIsLoadingToggle() {
        interactor.confirmCheckInEventIDEmailCompleteNameReturnValue = .just(())
        sut.input.didCompleteNameChange.onNext("wellington")
        sut.input.didEmailChange.onNext("tatsu@gmail.com")
        sut.input.didConfirmCheckIn.onNext(())
        
        XCTAssertEqual(isLoading.events.compactMap { $0.value.element }, [false, true, false])
    }
    
    func test_shouldErrorReturn() {
        let expectedError = NSError(domain: "", code: 1, userInfo: nil)
        interactor.confirmCheckInEventIDEmailCompleteNameReturnValue = .error(expectedError)
        sut.input.didCompleteNameChange.onNext("wellington")
        sut.input.didEmailChange.onNext("tatsu@gmail.com")
        sut.input.didConfirmCheckIn.onNext(())
        
        XCTAssertEqual(error.events.compactMap { $0.value.element as NSError? }, [expectedError])
    }
}
